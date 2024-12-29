import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indragram/class/handle_text.dart';
import 'package:indragram/my_widget/my_widget.input.dart';
import 'package:indragram/my_widget/my_widget.loading.dart';

import 'controllers/register.controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MyWidgetLoading(
        loading: controller.loading.value,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Daftar',
              style: TextStyle(fontFamily: 'Instagram'),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
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
                          Image.asset('assets/images/foodgram_logo.png', height: 100),
                          Column(
                            children: [
                              // 082133651063
                              SizedBox(height: 40.0),
                              MyWidgetInput(hint: 'Nomor hp. Cth: 082983892009', keyboardType: TextInputType.number, enabled: !controller.inputOtp.value, ctr: controller.ctrUsername.value),
                              SizedBox(height: 10.0),
                              MyWidgetInput(hint: 'Kata Sandi', enabled: !controller.inputOtp.value, pass: true, ctr: controller.ctrPassword.value),
                              SizedBox(height: 10.0),
                              MyWidgetInput(hint: 'Ulangi Kata Sandi', enabled: !controller.inputOtp.value, ctr: controller.ctrRePassword.value, pass: true),
                            ],
                          ),
                          controller.inputOtp.value
                              ? Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    MyWidgetInput(
                                      hint: 'Masukkan OTP',
                                      maxLength: 4,
                                      ctr: controller.ctrOTP.value,
                                      inputFormatters: [FormatterHurufBesar()],
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: controller.handleRegis,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Warna latar belakang biru
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(7.0), // Border radius untuk tombol
                              ),
                              // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0), // Ukuran tombol
                            ),
                            child: Center(child: Text('Daftar')),
                          ),
                          SizedBox(height: 135.0),
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
                                Text('Muh. Indra', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 12.0)),
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
      ),
    );
  }
}
