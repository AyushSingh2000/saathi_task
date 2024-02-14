import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirestoreHelper() {
    _db.settings = const Settings(persistenceEnabled: true);
  }
  Future<String?> setData(
      {required String collection,
        String? doc,
        dynamic data,
        bool merge = false}) async {
    if (doc == null) {
      final response = await _db.collection(collection).add(data);
      return response.id;
    } else {
      await _db
          .collection(collection)
          .doc(doc)
          .set(data, SetOptions(merge: merge));
      return null;
    }
  }

  Future<void> deleteData({
    required String collection,
    String? doc,
  }) async {
    _db.collection(collection).doc(doc).delete();
  }

  getData(String collection, String doc) {
    _db.collection(collection).doc(doc).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getList(String collection) async {
    return await _db.collection(collection).get();
  }
}
