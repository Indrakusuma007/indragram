import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indragram/my_widget/my_widget.snackbar.dart';

class ProfileController extends GetxController {
  var userDocId = ''.obs;
  var profilePictureUrl = ''.obs;
  var username = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    // Ganti dengan mekanisme yang sesuai untuk mendapatkan username pengguna
    String currentUsername = '1'; // Contoh username
    print('Current Username: $currentUsername');

    try {
      QuerySnapshot userDocs = await _firestore.collection('data_users').where('username', isEqualTo: currentUsername).get();
      if (userDocs.docs.isNotEmpty) {
        var userDoc = userDocs.docs.first;
        userDocId.value = userDoc.id;
        profilePictureUrl.value = userDoc['url_profile'] ?? '';
        username.value = userDoc['username'] ?? '';
        print('User Document ID: ${userDocId.value}');
        print('Profile Picture URL: ${profilePictureUrl.value}');
        print('Username: ${username.value}');
      } else {
        print('Dokumen pengguna tidak ditemukan di Firestore');
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      if (userDocId.value.isNotEmpty) {
        // Hapus dokumen pengguna dari Firestore
        await _firestore.collection('data_users').doc(userDocId.value).delete();
        print('Dokumen pengguna dihapus dari Firestore');

        // Navigasi ke halaman login
        Get.offAllNamed('/login');
        print('Navigasi ke halaman login');

        // Tampilkan snackbar sukses
        MyWidgetSnackbar.myTemplateSnackBarSuccess(message: 'Akun berhasil dihapus', title: 'Berhasil');
      } else {
        print('ID dokumen pengguna tidak ditemukan');
      }
    } catch (e) {
      // Tampilkan pesan kesalahan
      MyWidgetSnackbar.myTemplateSnackBarError(message: e.toString(), title: 'Peringatan!!');
      print('Error deleting account: $e');
    }
  }
}
