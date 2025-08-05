import '../../domain/entity/auth_article.dart';

class AuthModel extends AuthEntity {


  AuthModel({
    required String id,
    required String name,
    required String password,
    required String token,
    required String country,
    required CurrencyType currency,
    required bool isLogin,
  }) : super(
    id: id,
    name: name,
    password: password,
    token: token,
    country: country,
    currency: currency,
    isLogin: isLogin,
  );

  AuthModel copyWith({
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
      isLogin: isLogin ?? this.isLogin,
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
        orElse: () => CurrencyType.uk, // ✅ fallback if value is empty or wrong
      ),
      isLogin: map['isLogin'] ?? false,
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
      isLogin: entity.isLogin,
    );
  }
}
