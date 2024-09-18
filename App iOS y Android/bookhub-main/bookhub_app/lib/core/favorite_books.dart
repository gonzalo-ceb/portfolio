import '../presentation/inicio_page/inicio_page.dart';

class FavoriteBooks {
  static final List<Book> _favoriteBooks = [];

  static List<Book> get books => _favoriteBooks;

  static void add(Book book) {
    if (!_favoriteBooks.contains(book)) {
      _favoriteBooks.add(book);
    }
  }

  static void remove(Book book) {
    _favoriteBooks.remove(book);
  }
}