import 'package:equatable/equatable.dart';

class VirtualAccountEntity extends Equatable {
  final String? accountNumber;
  final String? iban;

  const VirtualAccountEntity({this.accountNumber, this.iban});

  @override
  List<Object?> get props => [accountNumber, iban];
}
