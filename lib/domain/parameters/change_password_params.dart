import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String password;
  final String passwordConfirm;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.password,
    required this.passwordConfirm,
  });

  @override
  List<Object?> get props => [oldPassword, password, passwordConfirm];
}
