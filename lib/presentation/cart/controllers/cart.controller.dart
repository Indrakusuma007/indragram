import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CartItem {
  final String name;
  final String photoUrl;
  final int price;
  int quantity;
  int get totalPrice => price * quantity;

  CartItem({required this.name, required this.photoUrl, required this.price, this.quantity = 1});
}

class CartController extends GetxController {
  var cart = <CartItem>[].obs;

  // Fungsi untuk menambahkan item ke keranjang
  void addToCart(String name, String photoUrl, int price) {
    var existingItem = cart.firstWhereOrNull((item) => item.name == name);
    if (existingItem != null) {
      existingItem.quantity++;
      cart.refresh();
    } else {
      cart.add(CartItem(name: name, photoUrl: photoUrl, price: price));
    }
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeFromCart(int index) {
    cart.removeAt(index);
  }

  // Fungsi untuk menghitung total harga
  int get totalPrice => cart.fold(0, (sum, item) => sum + item.totalPrice);

  // Fungsi untuk cek ongkir menggunakan API RajaOngkir
  Future<void> checkShippingCost(String origin, String destination, int weight) async {
    const String apiKey = 'fmm3gKgRb244f4336e8469714eFfr6eC';
    const String url = 'https://api.rajaongkir.com/starter/cost';
    final Dio dio = Dio();

    try {
      print('Mengirim permintaan ke $url dengan API key $apiKey');
      final response = await dio.post(
        url,
        data: {
          'origin': origin,
          'destination': destination,
          'weight': weight,
          'courier': 'jne', // Anda bisa mengganti dengan kurir lain seperti 'pos', 'tiki', dll.
        },
        options: Options(
          headers: {
            'key': apiKey,
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data['rajaongkir']['results'][0]['costs'];
        // Tampilkan hasil ongkir
        Get.snackbar('Ongkir', 'Biaya pengiriman: ${data[0]['cost'][0]['value']}');
      } else {
        Get.snackbar('Error', 'Gagal mendapatkan ongkir');
      }
    } on DioError catch (e) {
      // Tangani kesalahan DioError
      if (e.response != null) {
        print('DioError response data: ${e.response?.data}');
        Get.snackbar('Error', 'DioError: ${e.response?.data['rajaongkir']['status']['description']}');
      } else {
        print('DioError message: ${e.message}');
        Get.snackbar('Error', 'DioError: ${e.message}');
      }
    } catch (e) {
      // Tangani kesalahan lainnya
      print('Error: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
