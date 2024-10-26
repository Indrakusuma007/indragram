import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indragram/infrastructure/navigation/routes.dart';
import 'package:indragram/my_widget/my_widget.snackbar.dart';
import 'package:indragram/services/service.auth.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> ctrUsername = Rx(TextEditingController());
  final Rx<TextEditingController> ctrPassword = Rx(TextEditingController());
  final ServiceAuth serviceAuth = ServiceAuth();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future handleLogin() async {
    try {
      if (ctrUsername.value.text.isEmpty) throw 'Username atau no hp tidak boleh kosong';
      if (ctrPassword.value.text.isEmpty) throw 'Password tidak boleh kosong';
      final resultUser = await serviceAuth.cekExistUser(username: ctrUsername.value.text);
      if (resultUser.isEmpty) throw 'User tidak ditemukan';
      final String pass = resultUser.first['password'];
      if (ctrPassword.value.text != pass) throw 'Password salah';
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print(e);
      MyWidgetSnackbar.myTemplateSnackBarError(message: e.toString(), title: 'Peringatan!!');
    }
  }
}
