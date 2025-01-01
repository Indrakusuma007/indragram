import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indragram/services/service.otp.dart';
import 'package:indragram/infrastructure/navigation/routes.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ServiceOtp serviceOtp = ServiceOtp();
  final otpSent = false.obs;
  final otpVerified = false.obs;
  final loading = false.obs;
  final otp = ''.obs;

  Future<void> sendOtp() async {
    try {
      loading.value = true;
      String phoneNumber = phoneController.text;

      if (phoneNumber.isEmpty) throw 'Nomor telepon tidak boleh kosong';

      String? otpIn = await serviceOtp.sendOtp(noHp: phoneNumber);
      if (otpIn == null) throw 'OTP Tidak terkirim';

      // Simpan OTP ke Firestore
      await FirebaseFirestore.instance.collection('otp').doc(phoneNumber).set({
        'otp': otpIn,
        'createdAt': FieldValue.serverTimestamp(),
      });

      otp.value = otpIn;
      otpSent.value = true;
      Get.snackbar('Success', 'OTP telah dikirim melalui WhatsApp');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    try {
      loading.value = true;
      String phoneNumber = phoneController.text;
      String enteredOtp = otpController.text;

      if (enteredOtp.isEmpty) throw 'OTP tidak boleh kosong';

      // Verifikasi OTP dari Firestore
      var doc = await FirebaseFirestore.instance.collection('otp').doc(phoneNumber).get();
      if (doc.exists && doc['otp'] == enteredOtp) {
        otpVerified.value = true; // Set otpVerified ke true setelah OTP diverifikasi
        Get.snackbar('Success', 'OTP berhasil diverifikasi. Silakan masukkan password baru.');
      } else {
        throw 'OTP tidak valid';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> resetPassword() async {
    try {
      loading.value = true;
      String phoneNumber = phoneController.text;
      String newPassword = passwordController.text;

      if (newPassword.isEmpty) throw 'Password baru tidak boleh kosong';

      // Periksa apakah dokumen pengguna ada di Firestore
      var userDoc = await FirebaseFirestore.instance.collection('data_users').where('username', isEqualTo: phoneNumber).get();
      if (userDoc.docs.isEmpty) {
        throw 'Dokumen pengguna tidak ditemukan';
      }

      // Update password di Firestore
      await FirebaseFirestore.instance.collection('data_users').doc(userDoc.docs.first.id).update({
        'password': newPassword,
      });

      Get.snackbar('Success', 'Password berhasil diubah');
      // Navigasi kembali ke layar login
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }
}
