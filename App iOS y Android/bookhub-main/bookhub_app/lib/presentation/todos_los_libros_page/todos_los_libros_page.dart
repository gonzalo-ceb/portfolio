import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_search_view.dart';
import '../inicio_page/inicio_page.dart';
import '../todos_los_libros_page/widgets/book_item_widget.dart';
import '../detalle_libro_screen/detalle_libro_screen.dart';

// ignore_for_file: must_be_immutable
class TodosLosLibrosPage extends StatefulWidget {
  final List<Book> books;

  TodosLosLibrosPage({required this.books});

  @override
  _TodosLosLibrosPageState createState() => _TodosLosLibrosPageState();
}

class _TodosLosLibrosPageState extends State<TodosLosLibrosPage> {
  TextEditingController searchBarController = TextEditingController();
  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = widget.books;
    searchBarController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    searchBarController.removeListener(_filterBooks);
    searchBarController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    String query = _normalizeString(searchBarController.text);

    setState(() {
      filteredBooks = widget.books.where((book) {
        String bookTitle = _normalizeString(book.title);
        return bookTitle.contains(query);
      }).toList();
    });
  }

  String _normalizeString(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[áàäâã]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöôõ]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .replaceAll(RegExp(r'[ñ]'), 'n');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 392.h,
          decoration: AppDecoration.fillGray,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(context),
              SizedBox(height: 20.v),
              _buildAllBooksSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h, right: 24.h, top: 20.v),
      child: CustomSearchView(
        controller: searchBarController,
        hintText: "Buscar",
      ),
    );
  }

  /// Section Widget
  Widget _buildAllBooksSection(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 10.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todos los libros",
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: 14.v),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 240.v, // Ajustar la altura según sea necesario
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 24.h,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  return BookItemWidget(
                    book: book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleLibroScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}