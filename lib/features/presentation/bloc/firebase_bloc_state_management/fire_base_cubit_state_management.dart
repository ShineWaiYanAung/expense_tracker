import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/auth_article.dart';
import '../../../domain/repository/auth_repository.dart';
import 'firebase_cubit_state.dart';


class FirebaseCubit extends Cubit<FirebaseState> {
  AuthEntity? _currentUser;
  AuthEntity? get currentUser => _currentUser;

  final AuthRepository _authRepository;

  FirebaseCubit(this._authRepository) : super(FirebaseInitial());

  Future<void> loadAuths() async {
    emit(FirebaseLoading());
    try {
      final auths = await _authRepository.getSavedAuth();
      emit(FirebaseLoaded(auths));
    } catch (e) {
      emit(FirebaseFailure(e.toString()));
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String token,
    required String country,
    required void Function(String message) onFailure,
    required void Function(String message) onSuccess,
  }) async {
    emit(FirebaseLoading());
    try {
      final users = await _authRepository.getSavedAuth();
      final matchedUser = users.firstWhere(
            (user) => user.token == token,
        orElse: () => throw Exception('Invalid token'),
      );

      if (matchedUser.name.isNotEmpty || matchedUser.password.isNotEmpty) {
        onFailure('This token has already been used');
        emit(const FirebaseFailure('Token already used'));
        return;
      }

      final updatedUser = matchedUser.copyWith(
        name: username,
        password: password,
        country: country,
        isLogin: true,
      );

      await _authRepository.editAuth(updatedUser);

      _currentUser = updatedUser;
      onSuccess('Signed up successfully');
      emit(FirebaseLoginSuccess(_currentUser!));
    } catch (e) {
      onFailure('An error occurred');
      emit(FirebaseFailure(e.toString()));
    }
  }

  Future<void> login({
    required String username,
    required String password,
    required void Function(String message) onFailure,
    required void Function(String message) onSuccess,
  }) async {
    emit(FirebaseLoading());
    try {
      final users = await _authRepository.getSavedAuth();
      final matchedUser = users.firstWhere(
            (user) => user.name == username && user.password == password && user.isLogin,
        orElse: () => throw Exception("Invalid credentials"),
      );

      _currentUser = matchedUser;
      onSuccess("Login successful");
      emit(FirebaseLoginSuccess(_currentUser!));
    } catch (e) {
      print('Login error: $e');
      onFailure("Login failed");
      emit(FirebaseFailure(e.toString()));
    }
  }


  Future<void> saveAuth(AuthEntity auth) async {
    emit(FirebaseLoading());
    try {
      await _authRepository.saveAuth(auth);
      emit(FirebaseSuccess());
      await loadAuths(); // Reload after saving
    } catch (e) {
      emit(FirebaseFailure(e.toString()));
    }
  }

  Future<void> editAuth(AuthEntity auth) async {
    emit(FirebaseLoading());
    try {
      await _authRepository.editAuth(auth);
      emit(FirebaseSuccess());
      await loadAuths(); // Reload after editing
    } catch (e) {
      emit(FirebaseFailure(e.toString()));
    }
  }

  Future<void> deleteAuth(AuthEntity auth) async {
    emit(FirebaseLoading());
    try {
      await _authRepository.deleteAuth(auth);
      emit(FirebaseSuccess());
      await loadAuths(); // Reload after deleting
    } catch (e) {
      emit(FirebaseFailure(e.toString()));
    }
  }
}
