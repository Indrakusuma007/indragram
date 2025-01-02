import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indragram/class/format_rupiah.dart';
import 'controllers/home.controller.dart';
import 'package:indragram/presentation/cart/controllers/cart.controller.dart';

class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key, required this.url, required this.harga, required this.photoUrl, required this.name, required this.lokasi});
  final String? url;
  final String? photoUrl;
  final String name;
  final String lokasi;
  final int harga;

  @override
  Widget build(BuildContext context) {
    final lamp = false.obs;
    final random = Random();
    final List<Color> colorList = [
      Colors.blueAccent.shade100,
      Colors.redAccent.shade100,
      Colors.green.shade300,
      Colors.yellow.shade900,
    ];
    final CartController cartController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: Colors.grey.shade200),
                child: photoUrl == null ? Container() : ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.network(photoUrl!, fit: BoxFit.cover)),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    lokasi,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 13.0),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Obx(() => GestureDetector(
                  onTapUp: (details) {
                    lamp.value = false;
                  },
                  onTapDown: (details) {
                    lamp.value = true;
                  },
                  child: Container(color: Colors.white, child: Icon(lamp.value ? Icons.wb_incandescent_rounded : Icons.wb_incandescent_outlined))))
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: url == null ? Container() : Image.network(url!, fit: BoxFit.cover),
            ),
            Obx(() => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: MediaQuery.of(context).size.width,
                  height: 280.0,
                  decoration: BoxDecoration(color: lamp.value ? Colors.black : Colors.black.withOpacity(.2)),
                )),
            Obx(() => AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: lamp.value ? 1 : .0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 280.0,
                    child: Center(
                        child: Text(
                      'Tersedia!!',
                      style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                    )),
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Obx(() => AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        opacity: lamp.value ? 0 : 1.0,
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            Text('Rp', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 15.0)),
                            Text(' ${formatRupiah(harga)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                            SizedBox(width: 10.0)
                          ],
                        ),
                      )),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan item ke keranjang saat 'Beli sekarang' diklik
                        cartController.addToCart(name, photoUrl ?? '', harga);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorList[random.nextInt(colorList.length)],
                        shadowColor: Colors.white.withOpacity(.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(.0), // Border radius untuk tombol
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Beli sekarang',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios_outlined, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart)),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.comment)),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.paperPlane)),
              Expanded(child: Container()),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bookmark))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tersedia !!!', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}

/*
class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key, required this.url, required this.harga, required this.photoUrl, required this.name, required this.lokasi});
  final String? url;
  final String? photoUrl;
  final String name;
  final String lokasi;
  final int harga;

  @override
  Widget build(BuildContext context) {
    final lamp = false.obs;
    final random = Random();
    final List<Color> colorList = [
      Colors.blueAccent.shade100,
      Colors.redAccent.shade100,
      Colors.green.shade300,
      Colors.yellow.shade900,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: Colors.grey.shade200),
                child: photoUrl == null ? Container() : ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.network(photoUrl!, fit: BoxFit.cover)),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    lokasi,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 13.0),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Obx(() => GestureDetector(
                  onTapUp: (details) {
                    lamp.value = false;
                  },
                  onTapDown: (details) {
                    lamp.value = true;
                  },
                  child: Container(color: Colors.white, child: Icon(lamp.value ? Icons.wb_incandescent_rounded : Icons.wb_incandescent_outlined))))
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: url == null ? Container() : Image.network(url!, fit: BoxFit.cover),
            ),
            Obx(() => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: MediaQuery.of(context).size.width,
                  height: 280.0,
                  decoration: BoxDecoration(color: lamp.value ? Colors.black : Colors.black.withOpacity(.2)),
                )),
            Obx(() => AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: lamp.value ? 1 : .0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 280.0,
                    child: Center(
                        child: Text(
                      'Tersedia!!',
                      style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
                    )),
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Obx(() => AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        opacity: lamp.value ? 0 : 1.0,
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            Text('Rp', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 15.0)),
                            Text(' ${formatRupiah(harga)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                            SizedBox(width: 10.0)
                          ],
                        ),
                      )),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorList[random.nextInt(colorList.length)],
                        // foregroundColor: Colors.blueAccent,
                        // overlayColor: Colors.blueAccent,
                        // surfaceTintColor: Colors.blueAccent,
                        shadowColor: Colors.white.withOpacity(.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(.0), // Border radius untuk tombol
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Beli sekarang',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios_outlined, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart)),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.comment)),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.paperPlane)),
              Expanded(child: Container()),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bookmark))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tersedia !!!', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
*/
