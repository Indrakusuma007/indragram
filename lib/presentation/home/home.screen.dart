import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indragram/infrastructure/navigation/routes.dart';
import 'package:indragram/my_widget/my_widget.loading.dart';
import 'package:indragram/presentation/home/home.content.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MyWidgetLoading(
        loading: controller.loading.value,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Foodgram',
              style: TextStyle(fontFamily: 'Instagram'),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                Get.offAllNamed(Routes.LOGIN);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              SizedBox(width: 3.0),
            ],
          ),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.getData();
            },
            semanticsLabel: 'Loading',
            color: Colors.blue,
            backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              children: controller.dataContent.value
                  .map((e) => HomeContent(
                        name: e.nama ?? '-',
                        lokasi: e.lokasi ?? 'Kosong',
                        photoUrl: e.urlPhoto,
                        url: e.urlContent,
                        harga: e.harga,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
