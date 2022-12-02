class Product {
  Product({required this.name, required this.price, required this.inCart});
  final String name;
  final double price;
  int inCart;

  void addToCart() => inCart += 1;

  // used in .displayName and myShop.chooseProduct()
  String get initial => name.substring(0, 1);

  // used in myShop._list
  String get displayName => '($initial)$name.substring(1)}';
}