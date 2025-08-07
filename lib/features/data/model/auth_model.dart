import '../../domain/entity/auth_article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel extends AuthEntity {

  AuthModel({
    required DateTime expireAt,
    required String id,
    required String name,
    required String password,
    required String token,
    required String country,
    required CurrencyType currency,
    required bool isLogin,
  }) : super(
    expireAt: expireAt,
    id: id,
    name: name,
    password: password,
    token: token,
    country: country,
    currency: currency,
    isLogin: isLogin,
  );

  AuthModel copyWith({
    DateTime? expireAt,
    String? id,
    String? name,
    String? password,
    String? token,
    String? country,
    CurrencyType? currency,
    bool? isLogin,
  }) {
    return AuthModel(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      token: token ?? this.token,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      isLogin: isLogin ?? this.isLogin, expireAt: expireAt ?? this.expireAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'token': token,
      'country': country,
      'currency': currency.name,
      'isLogin': isLogin,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map, String id) {
    return AuthModel(
      id: id,
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      country: map['country'] ?? '',
      currency: CurrencyType.values.firstWhere(
            (e) => e.name == map['currency'],
        orElse: () => CurrencyType.uk,
      ),
      isLogin: map['isLogin'] ?? false,
      expireAt: map['expireAt'] != null
          ? (map['expireAt'] as Timestamp).toDate()
          : DateTime.now(), // fallback to now
    );
  }



  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      id: entity.id,
      name: entity.name,
      password: entity.password,
      token: entity.token,
      country: entity.country,
      currency: entity.currency,
      isLogin: entity.isLogin, expireAt: entity.expireAt,
    );
  }
}
