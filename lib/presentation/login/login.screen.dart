import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indragram/infrastructure/navigation/routes.dart';
import 'package:indragram/my_widget/my_widget.input.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/foodgram.png', height: 200),
                        SizedBox(height: 40.0),
                        MyWidgetInput(hint: 'Nomor hp. Cth: 082983892009', keyboardType: TextInputType.number, ctr: controller.ctrUsername.value),
                        SizedBox(height: 10.0),
                        MyWidgetInput(
                          hint: 'Kata Sandi',
                          ctr: controller.ctrPassword.value,
                          pass: true,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.FORGET_PASSWORD);
                                },
                                child: Text('Lupa password?', style: TextStyle(color: Colors.blue)))
                          ],
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: controller.handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Warna latar belakang biru
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0), // Border radius untuk tombol
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0), // Ukuran tombol
                          ),
                          child: Center(child: Text('Masuk')),
                        ),
                        SizedBox(height: 5.0),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Warna latar belakang biru
                            foregroundColor: Colors.grey.shade500,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(7.0), // Border radius untuk tombol
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0), // Ukuran tombol
                          ),
                          child: Center(child: Text('Daftar')),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Created By ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12.0)),
                              Text('KuzmaTech', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 12.0)),
                            ],
                          )),
                      Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
