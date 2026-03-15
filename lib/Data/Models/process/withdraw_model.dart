// Withdraw Response Model that extends from BaseModel

import '../../../index/index_main.dart';

class WithdrawResponseModel extends BaseModel {
  final WithdrawDataModel? data;

  WithdrawResponseModel({
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

  factory WithdrawResponseModel.fromJson(Map<String, dynamic> json) {
    return WithdrawResponseModel(
      data: json['data'] != null
          ? WithdrawDataModel.fromJson(json['data'])
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
    return {
      'data': data?.toJson(),
      ...super.toJson(), // Spread the BaseModel's fields
    };
  }
}

// Withdraw Data Model that extends WithdrawDataEntity
class WithdrawDataModel extends WithdrawDataEntity {
  @override
  final List<WithdrawModel>? items;
  @override
  final Meta? meta;

  const WithdrawDataModel({this.items, this.meta}) : super(items: items, meta: meta);

  factory WithdrawDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List?;
    List<WithdrawModel> itemsList = list != null
        ? list.map((i) => WithdrawModel.fromJson(i)).toList()
        : [];

    return WithdrawDataModel(
      items: itemsList,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

// Withdraw Model that extends WithdrawEntity
class WithdrawModel extends WithdrawEntity {
  const WithdrawModel({
    String? id,
    String? status,
    String? transferringStatus,
    String? amount,
    BankAccountModel? bankAccountModel,
    String? createdAt,
  }) : super(
         id: id,
         status: status,
         transferringStatus: transferringStatus,
         amount: amount,
         bankAccount: bankAccountModel,
         createdAt: createdAt,
       );

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'],
      status: json['status'],
      transferringStatus: json['transferringStatus'],
      amount: json['amount'],
      bankAccountModel: json['bank_account'] != null
          ? BankAccountModel.fromJson(json['bank_account'])
          : null,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'transferringStatus': transferringStatus,
      'amount': amount,
      'bank_account': (bankAccount as BankAccountModel?)?.toJson(),
      'created_at': createdAt,
    };
  }
}

// Bank Account Model

class BankAccountModel extends BankAccountEntity {
  const BankAccountModel({
    int? id,
    String? label,
    String? alias,
    String? iban,
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
         bankName: bankName,
         bankId: bankId,
         accountNumber: accountNumber,
         isPrimary: isPrimary,
         beneficiaryAddress1: beneficiaryAddress1,
         beneficiaryAddress2: beneficiaryAddress2,
         verified: verified,
       );

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'],
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
