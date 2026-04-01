import '../../../index/index_main.dart';

class KYCResponseModel extends BaseModel {
  final KYCQuestionsModel? data;

  KYCResponseModel({
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

  factory KYCResponseModel.fromJson(Map<String, dynamic> json) {
    return KYCResponseModel(
      data: json['data'] != null
          ? KYCQuestionsModel.fromJson(json['data'])
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

class KYCQuestionsModel extends KycQuestionsEntity {
  @override
  final List<KycItemModel>? questions;

  const KYCQuestionsModel({this.questions}) : super(questions: questions);

  factory KYCQuestionsModel.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List?;
    List<KycItemModel> itemsList =
        list != null ? list.map((i) => KycItemModel.fromJson(i)).toList() : [];
    return KYCQuestionsModel(questions: itemsList);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'questions': questions};
  }
}
