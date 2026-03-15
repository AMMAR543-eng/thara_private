class BankAccountDataEntity {
  final List<BankAccount_Entity>? bankAccounts;

  BankAccountDataEntity({this.bankAccounts});
}

class BankAccount_Entity {
  final int? id;
  final String? label;
  final String? alias;
  final String? iban;
  final String? bankName;
  final String? bic;
  final int? bankId;
  final String? accountNumber;
  final bool? isPrimary;
  final String? beneficiaryAddress1;
  final String? beneficiaryAddress2;
  final bool? verified;

  BankAccount_Entity({
    this.id,
    this.label,
    this.alias,
    this.iban,
    this.bankName,
    this.bic,
    this.bankId,
    this.accountNumber,
    this.isPrimary,
    this.beneficiaryAddress1,
    this.beneficiaryAddress2,
    this.verified,
  });
}
