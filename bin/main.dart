import 'dart:io';

import 'package:test/product.dart';
import 'package:test/my_shop_extensions.dart';

final myShop = [
  Product(name: 'apples', price: 1.60, inCart: 0),
  Product(name: 'bananas', price: 0.70, inCart: 0),
  Product(name: 'courgettes', price: 1.0, inCart: 0),
  Product(name: 'grapes', price: 2.00, inCart: 0),
  Product(name: 'mushrooms', price: 0.80, inCart: 0),
  Product(name: 'potatoes', price: 1.50, inCart: 0),
];

void main() {
  while (true) {
    stdout.write(
        'What do you want to do? (v)iew items, (a)dd item, (c)heckout: ');
    final line = stdin.readLineSync();
    if (line == 'a') {
      final product = myShop.chooseProduct();
      if (product == null) {print('Not found.');}
      else {
        product.addToCart();
        print(myShop.cart);
      }
    } else if (line == 'v') {
      print(myShop.cart);
    } else if (line == 'c') {
      if (myShop.checkout()) {
        break;
      }
    }
  }
}
