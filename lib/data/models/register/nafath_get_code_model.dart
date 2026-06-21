import '../../../index/index_main.dart';

class NafathGetCodeModel extends BaseModel {
  final NafathCodeModel? data;

  NafathGetCodeModel({
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

  factory NafathGetCodeModel.fromJson(Map<String, dynamic> json) {
    return NafathGetCodeModel(
      data:
          json['data'] != null ? NafathCodeModel.fromJson(json['data']) : null,
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

class NafathCodeModel extends NafathCodeEntity {
  @override
  final String? random;
  @override
  final bool? completed;

  const NafathCodeModel({this.random, this.completed})
      : super(random: random, completed: completed);

  factory NafathCodeModel.fromJson(Map<String, dynamic> json) {
    return NafathCodeModel(
      random: json['random'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'random': random, 'completed': completed};
  }
}
