import 'package:equatable/equatable.dart';

class ChangeEmailParams extends Equatable {
  final String email;

  const ChangeEmailParams({required this.email});

  @override
  List<Object?> get props => [email];
}
