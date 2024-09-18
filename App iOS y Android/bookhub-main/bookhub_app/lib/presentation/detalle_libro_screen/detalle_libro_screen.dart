import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../inicio_page/inicio_page.dart';

class DetalleLibroScreen extends StatefulWidget {
  final Book book;

  DetalleLibroScreen({required this.book});

  @override
  _DetalleLibroScreenState createState() => _DetalleLibroScreenState();
}

class _DetalleLibroScreenState extends State<DetalleLibroScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    isFavorite = FavoriteBooks.books.contains(widget.book);
  }

  void toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await FavoriteBooks.add(widget.book);
    } else {
      await FavoriteBooks.remove(widget.book);
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
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: SizeUtils.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 527.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        height: 527.v,
                        width: 393.h,
                        child: ClipRRect(
                          child: widget.book.imageUrl.contains('assets/images')
                              ? Image.asset(
                            widget.book.imageUrl,
                            height: 527.v,
                            width: 393.h,
                            fit: BoxFit.cover,
                          )
                              : Image.file(
                            File(widget.book.imageUrl),
                            height: 527.v,
                            width: 393.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 527.v,
                                width: 393.h,
                                color: Colors.grey,
                                child: Center(
                                  child: Text('Error loading image'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowLeft,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          left: 20.h,
                          top: 29.v,
                        ),
                        onTap: () {
                          onTapImgArrowleftone(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              _buildColumnfavone(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnfavone(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 34.h,
          vertical: 38.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: CustomTextStyles.titleMedium18,
                      ),
                      SizedBox(height: 7.v),
                      Text(
                        widget.book.author,
                        style: theme.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
              ),
              SizedBox(height: 42.v),
              Text(
                "Sobre el libro",
                style: CustomTextStyles.titleMedium18,
              ),
              SizedBox(height: 7.v),
              Container(
                width: 284.h,
                margin: EdgeInsets.only(right: 38.h),
                child: Text(
                  widget.book.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 66.v),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.v,
                      bottom: 13.v,
                    ),
                    child: Text(
                      widget.book.price,
                      style: CustomTextStyles.titleMedium18,
                    ),
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Comprar",
                      margin: EdgeInsets.only(left: 39.h),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.v)
            ],
          ),
        ),
      ),
    );
  }

  void onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}

class FavoriteBooks {
  static List<Book> books = [];

  static Future<void> add(Book book) async {
    if (!books.contains(book)) {
      books.add(book);
      await saveFavorites();
    }
  }

  static Future<void> remove(Book book) async {
    if (books.contains(book)) {
      books.remove(book);
      await saveFavorites();
    }
  }

  static Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedBooks = jsonEncode(books.map((book) => book.toJson()).toList());
    await prefs.setString('favoriteBooks', encodedBooks);
  }
}