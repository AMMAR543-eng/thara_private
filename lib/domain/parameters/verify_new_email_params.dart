import 'package:equatable/equatable.dart';

class VerifyNewEmailParams extends Equatable {
  final String email;
  final String code;

  const VerifyNewEmailParams({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}
