import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    String? imageUrl,
  }) : imageUrl = imageUrl ?? 'https://down-id.img.susercontent.com/file/id-11134201-7r98x-lma1m2ws7ez0a6';
}

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    String? imageUrl,
  }) : imageUrl = imageUrl ?? 'https://down-id.img.susercontent.com/file/id-11134201-7r98x-lma1m2ws7ez0a6';
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  final List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Kertas HVS A4 80gsm',
      price: 50000,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134201-7r98x-lma1m2ws7ez0a6',
    ),
    Product(
      id: 'p2',
      title: 'Tinta Printer',
      price: 35000,
      imageUrl: 'https://minio.fixprint.id/fixprint/catalog/TINTA/tinta-refill-epson-original-003-black-65ml-tinta-refill-printer-epson-l1110-l3100-l3101-l3110-l3150-l5190-a14085.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Spidol papan tulis',
      price: 5000,
      imageUrl: 'https://cf.shopee.co.id/file/sg-11134201-22110-0iq266gdprjvd8',
    ),
    Product(
      id: 'p4',
      title: 'Map kertas',
      price: 2000,
      imageUrl: 'https://down-id.img.susercontent.com/file/f64ae01103ffbf85df551e770508a290',
    ),
    Product(
      id: 'p5',
      title: 'Buku agenda',
      price: 20000,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98o-lkrl54v3hxc2bd',
    ),
    Product(
      id: 'p6',
      title: 'Penggaris',
      price: 2000,
      imageUrl: 'https://img.lazcdn.com/g/p/cb4fc34fdf2cca9974ed99165dc3dbbc.jpg_720x720q80.jpg',
    ),
  ];

  List<Product> get products => _products;
  Map<String, CartItem> get items => _items;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          title: product.title,
          price: product.price,
          quantity: 1,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}