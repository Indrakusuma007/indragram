import 'package:get/get.dart';

// Definisikan model keranjang
class CartItem {
  final String name;
  final String photoUrl;
  int quantity;

  CartItem({required this.name, required this.photoUrl, this.quantity = 1});
}

class CartController extends GetxController {
  // List untuk menyimpan item keranjang
  var cart = <CartItem>[].obs;

  // Fungsi untuk menambahkan item ke keranjang
  void addToCart(String name, String photoUrl) {
    var existingItem = cart.firstWhereOrNull((item) => item.name == name);
    if (existingItem != null) {
      existingItem.quantity++;
      cart.refresh();
    } else {
      cart.add(CartItem(name: name, photoUrl: photoUrl));
    }
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeFromCart(int index) {
    cart.removeAt(index);
  }
}
