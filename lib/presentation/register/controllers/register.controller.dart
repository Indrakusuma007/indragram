import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indragram/my_widget/my_widget.snackbar.dart';
import 'package:indragram/services/service.auth.dart';
import 'package:indragram/services/service.otp.dart';

class RegisterController extends GetxController {
  final Rx<TextEditingController> ctrUsername = Rx(TextEditingController());
  final Rx<TextEditingController> ctrPassword = Rx(TextEditingController());
  final Rx<TextEditingController> ctrRePassword = Rx(TextEditingController());
  final Rx<TextEditingController> ctrOTP = Rx(TextEditingController());
  final RxBool inputOtp = false.obs;
  final RxBool loading = false.obs;
  final Rxn<String?> otp = Rxn();
  final ServiceOtp serviceOtp = ServiceOtp();
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

  Future handleRegis() async {
    try {
      if (loading.value) return;
      loading.value = true;
      if (!inputOtp.value) {
        if (ctrUsername.value.text.isEmpty) throw 'Username atau no hp tidak boleh kosong';
        if (ctrPassword.value.text.isEmpty) throw 'Password tidak boleh kosong';
        if (ctrRePassword.value.text.isEmpty) throw 'RePassword tidak boleh kosong';
        if (ctrRePassword.value.text != ctrPassword.value.text) throw 'Password tidak sama';

        final resultUser = await serviceAuth.cekExistUser(username: ctrUsername.value.text);
        if (resultUser.isNotEmpty) throw 'User telah terdaftar';

        final String? otpIn = await serviceOtp.sendOtp(noHp: ctrUsername.value.text);
        if (otpIn == null) throw 'OTP Tidak terkirim';
        inputOtp.value = true;
        otp.value = otpIn;
      } else {
        if (ctrOTP.value.text.isEmpty) throw 'OTP tidak boleh kosong';
        if (otp.value == null) throw 'Ada kesalahan, harap membuka ulang APP';
        if (ctrOTP.value.text != otp.value) throw 'OTP tidak sesuai';
        await serviceAuth.register(username: ctrUsername.value.text, password: ctrPassword.value.text);

        Get.back();
        MyWidgetSnackbar.myTemplateSnackBarSuccess(message: 'Berhasil', title: 'Kamu berhasil membuat user');
      }
    } catch (e) {
      print(e);
      MyWidgetSnackbar.myTemplateSnackBarError(message: e.toString(), title: 'Peringatan!!');
    }
    loading.value = false;
  }
}
