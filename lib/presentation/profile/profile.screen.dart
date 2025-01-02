import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/profile.controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'), // Ganti dengan path gambar profil Anda
            ),
            SizedBox(height: 20),
            Obx(() => Text(
                  'Phone Number: ${controller.phoneNumber.value}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna tombol delete
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                controller.deleteAccount();
              },
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
