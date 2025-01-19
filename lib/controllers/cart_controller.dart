import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  final RxDouble total = 0.0.obs;

  void addToCart(String title, String author, String price, String imageUrl) {
    // Convert price string to proper format
    final priceString = price.replaceAll(',', '');
    
    cartItems.add({
      'title': title,
      'author': author,
      'price': priceString,
      'imageUrl': imageUrl,
      'quantity': 1,
    });
    updateTotal();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    updateTotal();
  }

  void updateTotal() {
    total.value = cartItems.fold(0.0, (sum, item) {
      final price = double.parse(item['price'].toString().replaceAll(',', ''));
      return sum + (price * (item['quantity'] as int));
    });
  }
}
