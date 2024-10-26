import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indragram/model/model.data_content.dart';

class ServiceDataContent {
  CollectionReference firestore = FirebaseFirestore.instance.collection('data_content');

  Future<List<ModelDataContent>> getData() async {
    final result = await firestore.get();
    return result.docs.map((e) => ModelDataContent.fromMap(e.data() as Map<String, dynamic>)).toList();
  }
}
