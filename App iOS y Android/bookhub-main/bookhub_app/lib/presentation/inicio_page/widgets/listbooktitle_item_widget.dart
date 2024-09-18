import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../detalle_libro_screen/detalle_libro_screen.dart';
import '../inicio_page.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
// class ListbooktitleItemWidget extends StatelessWidget {
//   final VoidCallback onTapColumnbooktitle;
//   final Book book;
//
//   ListbooktitleItemWidget({
//     required this.onTapColumnbooktitle,
//     required this.book,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 121.h,
//       child: GestureDetector(
//         onTap: () {
//           onTapColumnbooktitle.call();
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomImageView(
//               imagePath: ImageConstant.imgRectangle8,
//               height: 177.v,
//               width: 121.h,
//               radius: BorderRadius.circular(
//                 10.h,
//               ),
//             ),
//             SizedBox(height: 4.v),
//             Text(
//               "Título del libro",
//               style: theme.textTheme.labelLarge,
//             ),
//             Text(
//               "Autor del libro",
//               style: theme.textTheme.bodySmall,
//             ),
//             SizedBox(height: 8.v),
//             Text(
//               "0.00€",
//               style: theme.textTheme.labelMedium,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class ListbooktitleItemWidget extends StatelessWidget {
  final Book book;
  final VoidCallback? onTapBook;

  ListbooktitleItemWidget({Key? key, required this.book, this.onTapBook}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            CustomImageView(
              imagePath: book.imageUrl,
              height: 177.v,
              width: 121.h,
              radius: BorderRadius.circular(10.h),
            ),
            SizedBox(height: 4.v),
            Text(
              book.title,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              book.author,
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 8.v),
            Text(
              "0.00€",
              // Esto es estático, cámbialo si necesitas mostrar un precio real.
              style: theme.textTheme.labelMedium,
            )
          ],
        ),
      ),
    );
  }
}

  void onTapColumnbooktitle(BuildContext context, Book book) {
    Navigator.pushNamed(
      context,
      AppRoutes.detalleLibroScreen,
      arguments: book,
    );
  }


