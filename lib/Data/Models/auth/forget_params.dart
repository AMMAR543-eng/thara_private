import 'package:equatable/equatable.dart';

class ForgetParams extends Equatable {
  final String? email;
  final String? nin;
  final String? code;
  final String? password;
  final String? passwordConfirm;

  const ForgetParams({
    this.email,
    this.nin,
    this.code,
    this.password,
    this.passwordConfirm,
  });

  @override
  List<Object?> get props => [email, nin, code, password, passwordConfirm];
}
