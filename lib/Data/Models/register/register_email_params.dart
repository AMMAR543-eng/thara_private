import 'package:equatable/equatable.dart';

class RegisterEmailParams extends Equatable {
  final String email;
  final String password;
  final String passwordConfirm;
  final String type;

  const RegisterEmailParams({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.type,
  });

  @override
  List<Object?> get props => [email, password, passwordConfirm, type];
}
