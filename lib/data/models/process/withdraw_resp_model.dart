
import '../../../index/index_main.dart';

class WithdrawalResponseModel extends BaseModel {
  final WithdrawalDataModel? data;

  WithdrawalResponseModel({
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

  factory WithdrawalResponseModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalResponseModel(
      data: json['data'] != null
          ? WithdrawalDataModel.fromJson(json['data'])
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

class WithdrawalDataModel {
  final WithdrawModel? withdrawalRequest;

  WithdrawalDataModel({this.withdrawalRequest});

  factory WithdrawalDataModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalDataModel(
      withdrawalRequest: json['withdrawal_request'] != null
          ? WithdrawModel.fromJson(json['withdrawal_request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'withdrawal_request': withdrawalRequest?.toJson()};
  }
}
