import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final RxSet<String> favorites = <String>{}.obs;

  void toggleFavorite(String bookTitle) {
    if (favorites.contains(bookTitle)) {
      favorites.remove(bookTitle);
    } else {
      favorites.add(bookTitle);
    }
  }

  bool isFavorite(String bookTitle) {
    return favorites.contains(bookTitle);
  }
}
