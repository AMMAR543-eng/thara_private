import 'package:equatable/equatable.dart';

class BankAccountEntity extends Equatable {
  final int? id;
  final String? label;
  final String? alias;
  final String? iban;
  final String? bankName;
  final int? bankId;
  final String? accountNumber;
  final bool? isPrimary;
  final String? beneficiaryAddress1;
  final String? beneficiaryAddress2;
  final bool? verified;

  const BankAccountEntity({
    this.id,
    this.label,
    this.alias,
    this.iban,
    this.bankName,
    this.bankId,
    this.accountNumber,
    this.isPrimary,
    this.beneficiaryAddress1,
    this.beneficiaryAddress2,
    this.verified,
  });

  @override
  List<Object?> get props => [
    id,
    label,
    alias,
    iban,
    bankName,
    bankId,
    accountNumber,
    isPrimary,
    beneficiaryAddress1,
    beneficiaryAddress2,
    verified,
  ];
}
