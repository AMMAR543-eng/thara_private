import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String? email;
  final String? password;
  final String? biometrics;
  final String? token; // ✅ Added
  final String? udid; // ✅ Added

  const LoginParams({
    this.email,
    this.password,
    this.biometrics,
    this.token,
    this.udid,
  });

  /// 🔁 Converts parameters to JSON, only including non-null and non-empty fields
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (email != null && email!.trim().isNotEmpty) {
      data['email'] = email;
    }

    if (password != null && password!.trim().isNotEmpty) {
      data['password'] = password;
    }

    if (biometrics != null && biometrics!.isNotEmpty) {
      data['biometrics'] = biometrics;
    }

    if (token != null && token!.isNotEmpty) {
      data['token'] = token;
    }

    if (udid != null && udid!.isNotEmpty) {
      data['uuid'] = udid;
    }

    return data;
  }

  /// 🔄 Optional: Create from JSON if needed later
  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      biometrics: json['biometrics'],
      token: json['token'],
      udid: json['uuid'],
    );
  }

  @override
  List<Object?> get props => [email, password, biometrics, token, udid];
}
