import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAuth {
  CollectionReference firestore = FirebaseFirestore.instance.collection('data_users');
  Future cekExistUser({required String username}) async {
    // final result = await firestore.where({'username':username}).get();
  }
}
