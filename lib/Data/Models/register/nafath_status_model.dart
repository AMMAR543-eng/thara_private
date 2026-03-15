import '../../../index/index_main.dart';

class NafathStatusModel extends BaseModel {
  final NafathGetStatusModel? data;

  NafathStatusModel({
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

  factory NafathStatusModel.fromJson(Map<String, dynamic> json) {
    return NafathStatusModel(
      data:
          json['data'] != null
              ? NafathGetStatusModel.fromJson(json['data'])
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

class NafathGetStatusModel extends NafathStatusEntity {
  @override
  final String? status;
  @override
  final bool? completed;

  const NafathGetStatusModel({this.status, this.completed})
    : super(status: status, completed: completed);

  factory NafathGetStatusModel.fromJson(Map<String, dynamic> json) {
    return NafathGetStatusModel(
      status: json['status'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'status': status, 'completed': completed};
  }
}
