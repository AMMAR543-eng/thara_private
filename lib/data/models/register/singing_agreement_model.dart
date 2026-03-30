import '../../../index/index_main.dart';

class SingingAgreementModel extends BaseModel {
  final SingingDetailsModel? data;

  SingingAgreementModel({
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

  factory SingingAgreementModel.fromJson(Map<String, dynamic> json) {
    return SingingAgreementModel(
      data:
          json['data'] != null
              ? SingingDetailsModel.fromJson(json['data'])
              : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account:
          json['account'] != null
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

class SingingDetailsModel extends SingingDetailsEntity {
  @override
  final String? investAgreement;

  const SingingDetailsModel({this.investAgreement})
    : super(investAgreement: investAgreement);

  factory SingingDetailsModel.fromJson(Map<String, dynamic> json) {
    return SingingDetailsModel(
      investAgreement: json['invest_agreement'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'invest_agreement': investAgreement};
  }
}
