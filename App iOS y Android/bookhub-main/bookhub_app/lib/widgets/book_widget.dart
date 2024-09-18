import 'package:flutter/material.dart';
import '../core/favorite_books.dart';
import '../presentation/inicio_page/inicio_page.dart';

class BookWidget extends StatefulWidget {
  final Book book;
  BookWidget({required this.book});

  @override
  _BookWidgetState createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteBooks.books.contains(widget.book);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      FavoriteBooks.add(widget.book);
    } else {
      FavoriteBooks.remove(widget.book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.book.title),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        onPressed: toggleFavorite,
      ),
    );
  }
}