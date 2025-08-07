import 'package:equatable/equatable.dart';
import '../../../domain/entity/auth_article.dart';

abstract class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object?> get props => [];
}

class FirebaseInitial extends FirebaseState {}

class FirebaseLoading extends FirebaseState {}

class FirebaseSuccess extends FirebaseState {}

class FirebaseFailure extends FirebaseState {
  final String error;

  const FirebaseFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class FirebaseLoaded extends FirebaseState {
  final List<AuthEntity> auths;

  const FirebaseLoaded(this.auths);

  @override
  List<Object?> get props => [auths];
}

class FirebaseLoginSuccess extends FirebaseState {
  final AuthEntity user;

  const FirebaseLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}
