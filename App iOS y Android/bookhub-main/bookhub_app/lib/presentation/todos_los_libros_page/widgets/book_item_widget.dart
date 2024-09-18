import 'package:flutter/material.dart';
import 'package:bookhub_app/presentation/inicio_page/inicio_page.dart';

class BookItemWidget extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  BookItemWidget({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              book.imageUrl,
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 6),
          Text(
            book.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}