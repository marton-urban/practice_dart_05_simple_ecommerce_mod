import 'dart:io';
import 'package:collection/collection.dart';
import 'package:test/product_extensions.dart';

extension MyShopExtensions on List<Map<String, Object>?> {
  // used in .chooseProduct()
  String get _list =>
      map((product) => '${product!.displayName}: \$${product['price']}')
          .join('\n');

  Map<String, Object>? chooseProduct() {
    stdout.write('Available products:\n$_list\nYour choice: ');
    final line = stdin.readLineSync();
    for (var product in this) {
      if (product!.initial == line) {
        return product;
      }
    }
    print('Not found');
    return null;
  }

  // used in .cart and .checkout()
  bool get _cartIsEmpty =>
      firstWhereOrNull((product) => product!['inCart'] != 0) == null;

  // used in .cart
  String get _inCartDisplay => where((product) => product!['inCart'] as int > 0)
      .map((product) =>
          '${product!['inCart']} x ${product['name']}: \$${(product['inCart'] as int) * (product['price'] as double)}')
      .join('\n');

  // used in .cart and .checkout()
  double get _inCartTotal => where((product) => product!['inCart'] as int > 0)
      .map((product) =>
          (product!['inCart'] as int) * (product['price'] as double))
      .reduce((value, element) => (value + element));

  String get cart {
    if (_cartIsEmpty) {
      return 'Cart is empty';
    }
    return '------\n$_inCartDisplay\nTotal: \$${_inCartTotal.toStringAsFixed(1)}\n------';
  }

  bool checkout() {
    if (_cartIsEmpty) {
      print('Cart is empty');
      return false;
    }
    final total = _inCartTotal;
    print('Total: \$$total');
    stdout.write('Payment in cash: ');
    final line = stdin.readLineSync();
    if (line == null || line.isEmpty) {
      return false;
    }
    final paid = double.tryParse(line);
    if (paid == null) {
      return false;
    }
    if (paid >= total) {
      final change = paid - total;
      print('Change: \$${change.toStringAsFixed(2)}');
      return true;
    } else {
      print('Not enough cash.');
      return false;
    }
  }
}
