

import '../../../index/index_main.dart';

class InvestmentTransactionsResponseModel extends BaseModel {
  final InvestmentTransactionDataModel? data;

  InvestmentTransactionsResponseModel({
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

  factory InvestmentTransactionsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvestmentTransactionsResponseModel(
      data: json['data'] != null
          ? InvestmentTransactionDataModel.fromJson(json['data'])
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
