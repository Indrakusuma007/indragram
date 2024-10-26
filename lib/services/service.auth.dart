import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAuth {
  CollectionReference firestore = FirebaseFirestore.instance.collection('data_users');
  Future register({required String username, required String password}) async {
    await firestore.add({'username': username, 'password': password});
  }

  Future<List<QueryDocumentSnapshot>> cekExistUser({required String username}) async {
    final result = await firestore.where('username', isEqualTo: username).get();
    return result.docs;
  }
}
