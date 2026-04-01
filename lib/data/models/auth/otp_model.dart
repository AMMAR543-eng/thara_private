import '../../../index/index_main.dart';

class OtpModel extends BaseEntity {
  const OtpModel({
    final int? customStatusCode,
    final String? message,
    final bool? debug,
    final String? env,
    final AccountModel? account,
    final UserModel? user,
  }) : super(
          customStatusCode: customStatusCode,
          message: message,
          debug: debug,
          env: env,
          account: account,
          user: user,
        );

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      customStatusCode: json['customStatusCode'] as int,
      message: json['message'] as String,
      debug: json['debug'] as bool,
      env: json['env'] as String,
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
      'account': account,
      'user': user,
    };
  }
}
