import 'package:get/get.dart';

class CartController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> item) {
    items.add(item);
    Get.snackbar('Berhasil', '${item['name']} berhasil ditambahkan ke keranjang');
  }

  void removeFromCart(Map<String, dynamic> item) {
    items.remove(item);
    Get.snackbar('Berhasil', '${item['name']} berhasil dihapus dari keranjang');
  }

  void clearCart() {
    items.clear();
    Get.snackbar('Berhasil', 'Keranjang berhasil dikosongkan');
  }
}
