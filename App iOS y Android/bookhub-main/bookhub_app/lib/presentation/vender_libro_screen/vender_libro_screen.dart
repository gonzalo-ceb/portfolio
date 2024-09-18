import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../inicio_page/inicio_page.dart';

List<Book> booksForSale = [];

Future<void> addToBooksForSale(Book book) async {
  if (!booksForSale.contains(book)) {
    booksForSale.add(book);
    await saveBooksForSale();
  }
}

Future<void> saveBooksForSale() async {
  final prefs = await SharedPreferences.getInstance();
  final String encodedBooks = jsonEncode(booksForSale.map((book) => book.toJson()).toList());
  await prefs.setString('booksForSale', encodedBooks);
}

Future<void> loadBooksForSale() async {
  final prefs = await SharedPreferences.getInstance();
  final String? encodedBooks = prefs.getString('booksForSale');
  if (encodedBooks != null) {
    final List<dynamic> decodedBooks = jsonDecode(encodedBooks);
    booksForSale = decodedBooks.map((json) => Book.fromJson(json)).toList();
  }
}

class VenderLibroScreen extends StatefulWidget {
  final Function(Book) onBookAdded;

  VenderLibroScreen({required this.onBookAdded, Key? key}) : super(key: key);

  @override
  _VenderLibroScreenState createState() => _VenderLibroScreenState();
}

class _VenderLibroScreenState extends State<VenderLibroScreen> {
  TextEditingController edittextController = TextEditingController();
  TextEditingController edittextoneController = TextEditingController();
  TextEditingController edittexttwoController = TextEditingController();
  TextEditingController edittextthreeController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    loadBooksForSale();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppbar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 34.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Detalles del libro",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 31.v),
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Container(
                    width: 151.h,
                    height: 231.v,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                    child: Center(
                      child: Text(
                        'No has seleccionado una imagen',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: 151.h,
                      height: 231.v,
                    ),
                  ),
                ),
                SizedBox(height: 31.v),
                _buildTitulo(context),
                SizedBox(height: 17.v),
                _buildAutor(context),
                SizedBox(height: 18.v),
                _buildDescripcion(context),
                SizedBox(height: 17.v),
                _buildRowPrecio(context),
                SizedBox(height: 5.v)
              ],
            ),
          ),
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
          onTapVectorone(context);
        },
      ),
    );
  }

  Widget _buildTitulo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Título",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 6.v),
        CustomTextFormField(
          controller: edittextController,
        )
      ],
    );
  }

  Widget _buildAutor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Autor",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 6.v),
        CustomTextFormField(
          controller: edittextoneController,
        )
      ],
    );
  }

  Widget _buildDescripcion(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descripción",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 5.v),
        CustomTextFormField(
          controller: edittexttwoController,
        )
      ],
    );
  }

  Widget _buildRowPrecio(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Precio",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 6.v),
              Container(
                width: 145.h,
                child: TextFormField(
                  controller: edittextthreeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Precio",
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),
        CustomElevatedButton(
          height: 60.v,
          width: 162.h,
          text: "Vender",
          margin: EdgeInsets.only(top: 15.v),
          onPressed: _saveBook,
        )
      ],
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = pickedFile != null ? File(pickedFile.path) : null;
      });
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error seleccionando la imagen: $e')),
      );
    }
  }

  void _saveBook() async {
    if (_image == null ||
        edittextController.text.isEmpty ||
        edittextoneController.text.isEmpty ||
        edittexttwoController.text.isEmpty ||
        edittextthreeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, completa todos los campos.'),
        ),
      );
      return;
    }

    final newBook = Book(
      title: edittextController.text,
      author: edittextoneController.text,
      description: edittexttwoController.text,
      price: edittextthreeController.text,
      imageUrl: _image!.path,
    );

    await addToBooksForSale(newBook);
    widget.onBookAdded(newBook);

    print('Saved image path: ${_image!.path}');

    Navigator.pop(context);

    edittextController.clear();
    edittextoneController.clear();
    edittexttwoController.clear();
    edittextthreeController.clear();
    setState(() {
      _image = null;
    });
  }

  void onTapVectorone(BuildContext context) {
    Navigator.pop(context);
  }
}