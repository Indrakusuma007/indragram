import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indragram/my_widget/my_widget.snackbar.dart';

class ProfileController extends GetxController {
  var phoneNumber = 'User'.obs;
  var userDocId = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    // Ganti dengan nomor telepon pengguna yang sedang login
    String currentPhoneNumber = '082133651063'; // Contoh nomor telepon

    QuerySnapshot userDocs = await _firestore.collection('data_users').where('username', isEqualTo: currentPhoneNumber).get();
    if (userDocs.docs.isNotEmpty) {
      var userDoc = userDocs.docs.first;
      phoneNumber.value = userDoc['username'];
      userDocId.value = userDoc.id;
      print('User Document ID: ${userDocId.value}');
    } else {
      print('Dokumen pengguna tidak ditemukan di Firestore');
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
