import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indragram/presentation/forget_password/controllers/forget_password.controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/foodgram.png',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.otpSent.value && !controller.otpVerified.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.otpController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan OTP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                } else if (controller.otpVerified.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password Baru',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    if (controller.otpSent.value && !controller.otpVerified.value) {
                      controller.verifyOtp();
                    } else if (controller.otpVerified.value) {
                      controller.resetPassword();
                    } else {
                      controller.sendOtp();
                    }
                  },
                  child: Obx(() => controller.loading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(controller.otpSent.value ? (controller.otpVerified.value ? 'Reset Password' : 'Verifikasi OTP') : 'Kirim OTP')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
