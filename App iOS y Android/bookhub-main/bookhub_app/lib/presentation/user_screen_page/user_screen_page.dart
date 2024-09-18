import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../inicio_page/widgets/book_item_widget.dart';
import '../todos_los_libros_page/todos_los_libros_page.dart';
import '../vender_libro_screen/vender_libro_screen.dart';
import '../inicio_page/inicio_page.dart';
import '../detalle_libro_screen/detalle_libro_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _loadBooksForSale();
    _loadFavorites();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('profile_image', pickedFile.path);
    }
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _loadBooksForSale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedBooks = prefs.getString('booksForSale');
    if (encodedBooks != null) {
      final List<dynamic> decodedBooks = jsonDecode(encodedBooks);
      setState(() {
        booksForSale = decodedBooks.map((json) => Book.fromJson(json)).toList();
      });
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedBooks = prefs.getString('favoriteBooks');
    if (encodedBooks != null) {
      final List<dynamic> decodedBooks = jsonDecode(encodedBooks);
      setState(() {
        FavoriteBooks.books = decodedBooks.map((json) => Book.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : NetworkImage('https://via.placeholder.com/150') as ImageProvider,
                ),
              ),
            ),
            SizedBox(height: 40),
            _buildColumnFavoritos(context),
            SizedBox(height: 40),
            _buildColumnLibrosEnVenta(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 392.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgVector,
        margin: EdgeInsets.fromLTRB(30.h, 19.v, 354.h, 20.v),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildColumnFavoritos(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 33.h),
              child: _buildLibrosparati(
                context,
                parati: "Tus favoritos",
                showVerTodos: true,
              ),
            ),
            SizedBox(height: 11.v),
            SizedBox(
              height: 267.v,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 21.h,
                  );
                },
                itemCount: FavoriteBooks.books.length,
                itemBuilder: (context, index) {
                  final book = FavoriteBooks.books[index];
                  return BookItemWidget(
                    book: book,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnLibrosEnVenta(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 33.h),
              child: Text(
                "Libros en venta",
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: appTheme.black900,
                ),
              ),
            ),
            SizedBox(height: 11.v),
            SizedBox(
              height: 250.v,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 21.h,
                  );
                },
                itemCount: booksForSale.length,
                itemBuilder: (context, index) {
                  final book = booksForSale[index];
                  return BookItemWidget(
                    book: book,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrosparati(BuildContext context, {
    required String parati,
    required bool showVerTodos,
  }) {
    return Row(
      children: [
        Text(
          parati,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: appTheme.black900,
          ),
        ),
        Spacer(),
        if (showVerTodos)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosLosLibrosPage(books: FavoriteBooks.books),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 11.v,
                bottom: 2.v,
              ),
              child: Text(
                "Ver todos",
                style: CustomTextStyles.labelLargeBlue400.copyWith(
                  color: appTheme.blue400,
                ),
              ),
            ),
          )
      ],
    );
  }
}