import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/data/model/auth_model.dart';

class FirebaseStoreService {
  final CollectionReference _authCollection =
  FirebaseFirestore.instance.collection('users');

  /// Fetch all saved auth data from Firestore
  Future<List<AuthModel>> getSavedAuth() async {
    final querySnapshot = await _authCollection.get();
    return querySnapshot.docs.map((doc) {
      return AuthModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  /// Save new auth entry to Firestore
  Future<String> saveAuth(AuthModel auth) async {
    final docRef = await _authCollection.add(auth.toMap());
    return docRef.id; // Return the generated Firestore document ID
  }


  /// Delete an auth entry by document ID
  Future<void> deleteAuth(AuthModel auth) async {
    await _authCollection.doc(auth.id).delete();
  }

  /// Edit an existing auth entry by document ID
  Future<void> editAuth(AuthModel auth) async {
    await _authCollection.doc(auth.id).update(auth.toMap());
  }
}
