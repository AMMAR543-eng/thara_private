import '../../../index/index_main.dart';

class BaseModel {
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;
  final AccountModel? account;
  final UserModel? user;

  BaseModel({
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
    this.account,
    this.user,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
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

  Map<String, dynamic> toJson() {
    return {
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
      'account': account?.toJson(),
      'user': user?.toJson(),
    };
  }
}
