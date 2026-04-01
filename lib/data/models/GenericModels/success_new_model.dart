import '../../../index/index_main.dart';

class SuccessNewModel extends BaseModel {
  final List<dynamic>? data;

  SuccessNewModel({
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

  factory SuccessNewModel.fromJson(Map<String, dynamic> json) {
    return SuccessNewModel(
      data: json['data'] as List<dynamic>?,
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
    return {'data': data, ...super.toJson()};
  }
}
