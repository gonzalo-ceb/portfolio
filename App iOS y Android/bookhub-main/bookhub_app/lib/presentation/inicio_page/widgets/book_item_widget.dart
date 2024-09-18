import 'package:bookhub_app/presentation/detalle_libro_screen/detalle_libro_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../core/app_export.dart';
import '../inicio_page.dart';

class BookItemWidget extends StatelessWidget {
  final Book book;

  BookItemWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    print('Loading image from: ${book.imageUrl}');
    return SizedBox(
      width: 121.h,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalleLibroScreen(book: book),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: book.imageUrl.contains('assets/images')
                  ? Image.asset(
                book.imageUrl,
                height: 195.v,
                width: 121.h,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(book.imageUrl),
                height: 195.v,
                width: 121.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 195.v,
                    width: 121.h,
                    color: Colors.grey,
                    child: Center(
                      child: Text('Error loading image'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 3.v),
            Text(
              book.title,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              book.author,
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 3.v),
            Text(
              book.price,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}