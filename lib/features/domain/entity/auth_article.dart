import 'package:equatable/equatable.dart';

enum CurrencyType { uk, japan }

class AuthEntity extends Equatable {
  final DateTime expireAt;
  final String id;
  final String name;
  final String password;
  final String token;
  final bool isLogin;
  final String country;
  final CurrencyType currency;

  const AuthEntity(  {
    required this.expireAt,
    required this.id,
    required this.name,
    required this.password,
    required this.token,
    required this.isLogin,
    required this.country,
    required this.currency,
  });
  AuthEntity copyWith({
    DateTime? expireAt,
    String? name,
    String? password,
    String? token,
    bool? isLogin,
    String? country,
    CurrencyType? currency,
    String? id,
  }) {
    return AuthEntity(
      name: name ?? this.name,
      password: password ?? this.password,
      token: token ?? this.token,
      isLogin: isLogin ?? this.isLogin,
      country: country ?? this.country,
      currency: currency ?? this.currency, id: id ?? this.id,
      expireAt: expireAt ?? this.expireAt

    );
  }
  @override
  List<Object?> get props => [
    name,
    password,
    token,
    isLogin,
    country,
    currency,
    id,
    expireAt
  ];
}
