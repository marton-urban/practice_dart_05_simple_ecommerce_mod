extension ProductExtensions on Map<String, Object> {
  // used in .displayName and myShop.chooseProduct()
  String get initial => (this['name'] as String).substring(0, 1);

  // used in myShop._list
  String get displayName =>
      '($initial)${(this['name'] as String).substring(1)}';

  void addToCart() => this['inCart'] = (this['inCart'] as int) + 1;
}
