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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        controller.addToCart(controller.cart[index].name, controller.cart[index].photoUrl, controller.cart[index].price);
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${controller.cart[index].name} (${controller.cart[index].quantity})'),
                                  Text('Rp ${controller.cart[index].totalPrice}'),
                                ],
                              ),
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
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rp ${controller.totalPrice}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Ganti 'origin', 'destination', dan 'weight' dengan nilai yang sesuai
                        controller.checkShippingCost('501', '114', 1700);
                      },
                      child: Text('Cek Ongkir'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
