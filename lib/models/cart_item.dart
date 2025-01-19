class CartItem {
  final String title;
  final String author;
  final String price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}
