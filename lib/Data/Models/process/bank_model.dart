import '../../../index/index_main.dart';

class BankAccountsResponseModel extends BaseModel {
  final BankAccountDataModel? data;

  BankAccountsResponseModel({
    this.data,
    int? customStatusCode,
    String? message,
    bool? debug,
    String? env,
    AccountModel? account,
    UserModel? user,
  }) : super(
         customStatusCode: customStatusCode,
         message: message,
         debug: debug,
         env: env,
         account: account,
         user: user,
       );

  factory BankAccountsResponseModel.fromJson(Map<String, dynamic> json) {
    return BankAccountsResponseModel(
      data: json['data'] != null
          ? BankAccountDataModel.fromJson(json['data'])
          : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'data': data?.toJson(), ...super.toJson()};
  }
}

class BankAccountDataModel extends BankAccountDataEntity {
  @override
  final List<BankAccount_Model>? bankAccounts;

  BankAccountDataModel({this.bankAccounts}) : super(bankAccounts: bankAccounts);

  factory BankAccountDataModel.fromJson(Map<String, dynamic> json) {
    return BankAccountDataModel(
      bankAccounts: (json['bank_accounts'] as List?)
          ?.map((e) => BankAccount_Model.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'bank_accounts': bankAccounts?.map((e) => e.toJson()).toList()};
  }
}

class BankAccount_Model extends BankAccount_Entity {
  BankAccount_Model({
    int? id,
    String? label,
    String? alias,
    String? iban,
    String? bic,
    String? bankName,
    int? bankId,
    String? accountNumber,
    bool? isPrimary,
    String? beneficiaryAddress1,
    String? beneficiaryAddress2,
    bool? verified,
  }) : super(
         id: id,
         label: label,
         alias: alias,
         iban: iban,
         bic: bic,
         bankName: bankName,
         bankId: bankId,
         accountNumber: accountNumber,
         isPrimary: isPrimary,
         beneficiaryAddress1: beneficiaryAddress1,
         beneficiaryAddress2: beneficiaryAddress2,
         verified: verified,
       );

  factory BankAccount_Model.fromJson(Map<String, dynamic> json) {
    return BankAccount_Model(
      id: json['id'],
      bic: json['bic'],
      label: json['label'],
      alias: json['alias'],
      iban: json['iban'],
      bankName: json['bank_name'],
      bankId: json['bank_id'],
      accountNumber: json['account_number'],
      isPrimary: json['is_primary'],
      beneficiaryAddress1: json['beneficiary_address_1'],
      beneficiaryAddress2: json['beneficiary_address_2'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bic': bic,
      'label': label,
      'alias': alias,
      'iban': iban,
      'bank_name': bankName,
      'bank_id': bankId,
      'account_number': accountNumber,
      'is_primary': isPrimary,
      'beneficiary_address_1': beneficiaryAddress1,
      'beneficiary_address_2': beneficiaryAddress2,
      'verified': verified,
    };
  }
}
