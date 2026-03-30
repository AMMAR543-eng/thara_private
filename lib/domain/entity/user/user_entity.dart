import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? phoneNumber;
  String? biometricPassword;
  final String? type;
  final String? nin;
  final String? userType;
  final bool? twoFactorCodeSent;
  bool? passTwoFactor;
  final bool? needPassword;

  UserEntity({
    this.name,
    this.email,
    this.type,
    this.phoneNumber,
    this.biometricPassword,
    this.nin,
    this.userType,
    this.twoFactorCodeSent,
    this.passTwoFactor,
    this.needPassword,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    biometricPassword,
    nin,
    userType,
    type,
    twoFactorCodeSent,
    passTwoFactor,
    needPassword,
  ];
}
