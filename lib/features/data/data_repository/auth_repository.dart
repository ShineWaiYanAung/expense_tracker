
import 'package:expense_tracker/FireBase/FireBaseStore/fire_base_store_service.dart';
import 'package:expense_tracker/features/domain/repository/auth_repository.dart';

import '../../domain/entity/auth_article.dart';
import '../model/auth_model.dart';

class AuthRepoImplFireBase implements AuthRepository {
  final FirebaseStoreService _firebaseStoreService;

  AuthRepoImplFireBase(this._firebaseStoreService);

  @override
  Future<void> deleteAuth(AuthEntity auth) {
    return _firebaseStoreService.deleteAuth(AuthModel.fromEntity(auth));
  }

  @override
  Future<void> editAuth(AuthEntity auth) {
    return _firebaseStoreService.editAuth(AuthModel.fromEntity(auth));
  }

  @override
  Future<List<AuthEntity>> getSavedAuth() {
    return _firebaseStoreService.getSavedAuth();
  }

  @override
  Future<void> saveAuth(AuthEntity auth) {
    return _firebaseStoreService.saveAuth(AuthModel.fromEntity(auth));
  }
}
