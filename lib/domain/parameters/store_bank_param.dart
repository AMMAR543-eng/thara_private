class StoreBankParams {
  final String usedMethod;
  final String iban;
  final String accountNumber;
  final String alias;
  final String beneficiaryAddress1;
  final String beneficiaryAddress2;
  final int bankId;
  final String ibanCertificatePath; // local file path

  StoreBankParams({
    required this.usedMethod,
    required this.iban,
    required this.accountNumber,
    required this.alias,
    required this.beneficiaryAddress1,
    required this.beneficiaryAddress2,
    required this.bankId,
    required this.ibanCertificatePath,
  });

  /// Returns fields for `application/x-www-form-urlencoded` or multipart text fields
  Map<String, dynamic> toJson() {
    return {
      "used_method": usedMethod,
      "iban": iban,
      "account_number": accountNumber,
      "alias": alias,
      "beneficiary_address_1": beneficiaryAddress1,
      "beneficiary_address_2": beneficiaryAddress2,
      "bank_id": bankId.toString(),
    };
  }

  /// Returns file map to be attached via multipart
  Map<String, String> toFiles() {
    return {"ibanCertificate": ibanCertificatePath};
  }
}

class StoreBankWithLeanParams {
  final String usedMethod;
  final String iban;
  final String accountNumber;
  final String alias;
  final String beneficiaryAddress1;
  final String beneficiaryAddress2;

  StoreBankWithLeanParams({
    required this.usedMethod,
    required this.iban,
    required this.accountNumber,
    required this.alias,
    required this.beneficiaryAddress1,
    required this.beneficiaryAddress2,
  });

  /// Returns fields for `application/x-www-form-urlencoded` or multipart text fields
  Map<String, dynamic> toJson() {
    return {
      "used_method": usedMethod,
      "iban": iban,
      "account_number": accountNumber,
      "alias": alias,
      "beneficiary_address_1": beneficiaryAddress1,
      "beneficiary_address_2": beneficiaryAddress2,
    };
  }
}
