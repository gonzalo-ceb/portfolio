import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/book_item_widget.dart';
import 'package:bookhub_app/presentation/todos_los_libros_page/todos_los_libros_page.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class Book {
  final String title;
  final String author;
  final String imageUrl;
  final String description;
  final String price;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
    };
  }

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
    );
  }
}

class _InicioPageState extends State<InicioPage> {
  List<Book> books = [
    Book(
      title: "Tan poca vida",
      author: "Hanya Yanahigara",
      imageUrl: ImageConstant.img_libro1,
      description:
      "Tan poca vida es una novela escrita por Hanya Yanagihara que sigue la vida de cuatro amigos a lo largo de más de tres décadas en Nueva York. La historia centraliza en Jude St. Francis, un abogado brillante y reservado con un pasado traumático que lo atormenta continuamente. La novela aborda temas profundos y oscuros como el abuso, el trauma, la amistad y la lucha por la recuperación y el apoyo.",
      price: "23.65€",
    ),
    Book(
      title: "El último catón",
      author: "Matilde Asensi",
      imageUrl: ImageConstant.img_libro2,
      description:
      "El último Catón es una novela de Matilde Asensi que narra la historia de la hermana Ottavia Salina, una paleógrafa de renombre internacional que trabaja en el Archivo Secreto del Vaticano. La trama se inicia cuando Ottavia es asignada para descifrar unos enigmáticos tatuajes encontrados en el cadáver de un etíope, los cuales incluyen siete letras griegas y siete cruces. Este misterio está relacionado con los fragmentos de la Vera Cruz, la verdadera cruz en la que Cristo fue crucificado, que han sido robados en diferentes lugares del mundo.",
      price: "21.05€",
    ),
    Book(
      title: "La maestra",
      author: "José Antonio Lucero",
      imageUrl: ImageConstant.img_libro3,
      description:
      "En mayo de 1936, una joven viaja a un pequeño pueblo de la sierra gaditana para cumplir su vocación como maestra. Nerviosa, se prepara para enseñar a sus alumnos con los principios pedagógicos modernos de la República, pero la Guerra Civil lo cambiará todo. Acusada de adoctrinamiento, es arrestada y prohibida de enseñar, convirtiéndose en una de las muchas víctimas del conflicto. Treinta años después, una visita inesperada podría cambiar su destino.",
      price: "20.80€",
    ),
    Book(
      title: "La vida en un minuto",
      author: "José Antonio Lucero",
      imageUrl: ImageConstant.img_libro4,
      description:
      "La novela narra la historia de amor entre una enfermera y un soldado durante la Guerra Civil Española, explorando los sacrificios y la lucha por mantener la esperanza en tiempos de guerra.",
      price: "17.95€",
    ),
    Book(
      title: "El misterio de Chalk Hill",
      author: "Susanne Goga",
      imageUrl: ImageConstant.img_libro5,
      description:
      "En la Inglaterra victoriana, una joven institutriz llega a una mansión en Chalk Hill para cuidar de una niña huérfana. Pronto se ve envuelta en misteriosos sucesos que parecen estar relacionados con la madre fallecida de la niña, desentrañando secretos oscuros del pasado.",
      price: "18.90€",
    ),
    Book(
      title: "Los privilegios del ángel",
      author: "Dolores Redondo",
      imageUrl: ImageConstant.img_libro6,
      description:
      "La historia se centra en la profunda amistad entre dos niñas en un pequeño pueblo del norte de España y cómo un trágico acontecimiento marca sus vidas para siempre, explorando temas de pérdida, duelo y redención.",
      price: "12.30€",
    ),
    Book(
      title: "La grieta del silencio",
      author: "Javier Castillo",
      imageUrl: ImageConstant.img_libro7,
      description:
      "Una novela que mezcla thriller y drama, donde un hombre busca desesperadamente a su hija desaparecida en un contexto de secretos y peligros ocultos, enfrentándose a una red de mentiras y corrupción.",
      price: "20.80€",
    ),
    Book(
      title: "El vuelo de la mariposa",
      author: "David Olivas",
      imageUrl: ImageConstant.img_libro8,
      description:
      "La historia sigue a una mujer que, tras la muerte de su esposo, se embarca en un viaje de autodescubrimiento y transformación personal, enfrentando su pasado y redefiniendo su futuro.",
      price: "18.90€",
    ),
    Book(
      title: "La paciente silenciosa",
      author: "Alex Michaelides",
      imageUrl: ImageConstant.img_libro9,
      description:
      "Alicia Berenson, una famosa pintora, dispara a su marido y luego guarda silencio absoluto. Su terapeuta, obsesionado con descubrir la verdad, intenta romper su silencio, desentrañando una trama de misterio psicológico profundo.",
      price: "10.40€",
    ),
    Book(
      title: "Lo último que verán tus ojos",
      author: "Isabel San Sebastián",
      imageUrl: ImageConstant.img_libro10,
      description:
      "Una novela que mezcla la historia contemporánea y la Segunda Guerra Mundial, donde dos investigadores buscan un valioso cuadro desaparecido, revelando secretos ocultos de la época nazi y conectando pasados oscuros con el presente.",
      price: "30.00€",
    ),
    Book(
      title: "Bajo tierra seca",
      author: "César Pérez Gellida",
      imageUrl: ImageConstant.img_libro11,
      description:"Una novela que se adentra en los misterios de un pueblo perdido, donde las desapariciones y secretos ocultos bajo la tierra seca revelan una historia de venganza y redención. Con un ritmo trepidante y personajes profundos, Gellida nos lleva a un viaje oscuro y fascinante.",
      price: "21.75€",
    ),
    Book(
      title: "Esperando al diluvio",
      author: "Dolores Redondo",
      imageUrl: ImageConstant.img_libro12,
      description:"En esta emocionante novela, Redondo nos presenta a un detective que investiga una serie de crímenes misteriosos mientras lucha contra sus propios demonios internos. Con una atmósfera oscura y una trama llena de giros inesperados, esperando al diluvio es una lectura cautivadora que te mantendrá al borde del asiento.",
      price: "21.75€",
    ),
    Book(
      title: "La hija de la criada",
      author: "Barbara Mutch",
      imageUrl: ImageConstant.img_libro13,
      description: "Una conmovedora historia de amor y superación ambientada en Sudáfrica durante el apartheid. La hija de una criada lucha por encontrar su lugar en un mundo dividido por el racismo, enfrentando desafíos y descubriendo la verdad sobre su familia y su identidad.",
      price: "7.50€",
    ),
    Book(
      title: "El camino del despertar",
      author: "Mario Alonso Puig",
      imageUrl: ImageConstant.img_libro14,
      description: "Un viaje de autoconocimiento y crecimiento personal, donde el autor nos guía a través de técnicas y reflexiones para despertar nuestro verdadero potencial. Con ejemplos inspiradores y consejos prácticos, esta obra es una herramienta valiosa para transformar nuestra vida.",
      price: "19.85€",
    ),
    Book(
      title: "París despertaba tarde",
      author: "Máximo Huerta",
      imageUrl: ImageConstant.img_libro15,
      description: "Una novela que captura la magia y el encanto de París a través de los ojos de sus personajes. Huerta nos transporta a una ciudad llena de historias y secretos, donde los caminos de varios individuos se cruzan, revelando amores, sueños y desafíos.",
      price: "19.85€",
    ),
    Book(
      title: "El desorden que dejas",
      author: "Carlos Montero",
      imageUrl: ImageConstant.img_libro16,
      description: "Un thriller psicológico que sigue a una profesora que se traslada a un pequeño pueblo y se encuentra con una serie de misterios y peligros. A medida que descubre la verdad sobre su predecesora, su propia vida comienza a desmoronarse, atrapándola en una red de intrigas.",
      price: "18.90€",
    ),
    Book(
      title: "Alas de sangre",
      author: "Rebecca Yarros",
      imageUrl: ImageConstant.img_libro17,
      description: "Una historia de amor y sacrificio en medio de una guerra devastadora. Yarros nos presenta a dos almas perdidas que encuentran consuelo en el amor, enfrentando juntos los horrores del conflicto y luchando por sobrevivir y proteger lo que más aman.",
      price: "21.75€",
    ),
    Book(
      title: "La sangre del padre",
      author: "Alfonso Goizueta",
      imageUrl: ImageConstant.img_libro18,
      description: "Una novela de misterio y suspense que sigue a un joven investigador en su búsqueda de respuestas sobre la muerte de su padre. Enfrentando peligros y revelaciones sorprendentes, descubre una conspiración que amenaza con destruir todo lo que conoce.",
      price: "21.75€",
    ),
    Book(
      title: "La hija del relojero",
      author: "Kate Morton",
      imageUrl: ImageConstant.img_libro19,
      description: "Una historia de amor y misterio ambientada en varias épocas, donde una joven descubre secretos de su familia y de una casa antigua.",
      price: "20.90€",
    ),
    Book(
      title: "El campamento",
      author: "Blue Jeans",
      imageUrl: ImageConstant.img_libro20,
      description: "Un grupo de jóvenes asiste a un campamento donde comienzan a suceder extraños eventos, llevando a descubrir secretos y enfrentar peligros.",
      price: "19.90€",
    ),
    Book(
      title: "Invisible",
      author: "Eloy Moreno",
      imageUrl: ImageConstant.img_libro21,
      description: "Un joven se siente invisible para el mundo que lo rodea. Esta conmovedora historia aborda temas de bullying, amistad y superación personal.",
      price: "17.95€",
    ),
    Book(
      title: "El príncipe de la niebla",
      author: "Carlos Ruiz Zafón",
      imageUrl: ImageConstant.img_libro22,
      description: "Una novela de misterio y aventura donde un grupo de jóvenes descubre los oscuros secretos de su nuevo hogar en la costa.",
      price: "15.50€",
    ),
  ];

  List<Book> filteredBooks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
    searchController.addListener(_filterBooks);
  }

  void addBook(Book book) {
    setState(() {
      books.add(book);
      filteredBooks = books;
    });
  }

  void _filterBooks() {
    String query = _normalizeText(searchController.text);
    setState(() {
      filteredBooks = books.where((book) {
        return _normalizeText(book.title).contains(query);
      }).toList();
    });
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 45.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 33.h,
                    right: 35.h,
                  ),
                  child: CustomSearchView(
                    controller: searchController,
                    hintText: "Buscar",
                  ),
                ),
                SizedBox(height: 29.v),
                _buildColumntodoslos(context),
                SizedBox(height: 28.v),
                _buildColumnparati(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumntodoslos(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 33.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 33.h),
              child: _buildLibrosparati(
                context,
                parati: "Todos los libros",
                showVerTodos: true,
              ),
            ),
            SizedBox(height: 11.v),
            SizedBox(
              height: 270.v,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 21.h,
                  );
                },
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
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

  /// Section Widget
  Widget _buildColumnparati(BuildContext context) {
    List<Book> lastFiveBooks = filteredBooks.reversed.take(5).toList();
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 33.h, bottom: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 1.h,
                right: 32.h,
              ),
              child: _buildLibrosparati(
                context,
                parati: "Libros para ti",
                showVerTodos: false,  // No mostrar "Ver todos"
              ),
            ),
            SizedBox(height: 11.v),
            SizedBox(
              height: 270.v,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 1.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 21.h,
                  );
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  final book = lastFiveBooks[index];
                  return BookItemWidget(
                    book: book,
                  );
                },
              ),
            )
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
                  builder: (context) => TodosLosLibrosPage(books: books),
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