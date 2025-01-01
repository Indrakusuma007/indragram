import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart.controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return Center(
            child: Text('Keranjang Kosong !!!'),
          );
        } else {
          return ListView.builder(
            itemCount: controller.cart.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  controller.addToCart(controller.cart[index].name, controller.cart[index].photoUrl);
                },
                child: ListTile(
                  leading: Text('${index + 1}.'),
                  title: Row(
                    children: [
                      Image.network(
                        controller.cart[index].photoUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text('${controller.cart[index].name} (${controller.cart[index].quantity})'),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.removeFromCart(index);
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
