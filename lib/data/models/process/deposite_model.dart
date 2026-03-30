import '../../../index/index_main.dart';

class DepositeResponseModel extends BaseModel {
  final DepositeDataModel? data;

  DepositeResponseModel({
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

  factory DepositeResponseModel.fromJson(Map<String, dynamic> json) {
    return DepositeResponseModel(
      data: json['data'] != null
          ? DepositeDataModel.fromJson(json['data'])
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

class DepositeDataModel extends DepositeDataEntity {
  @override
  final List<DepositeModel>? items;
  @override
  final Meta? meta;

  const DepositeDataModel({this.items, this.meta})
    : super(items: items, meta: meta);

  factory DepositeDataModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List?;
    List<DepositeModel> itemsList = list != null
        ? list.map((i) => DepositeModel.fromJson(i)).toList()
        : [];

    return DepositeDataModel(
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

class DepositeModel extends DepositeEntity {
  const DepositeModel({
    String? amount,
    String? sourceIban,
    bool? knownSource,
    String? date,
    String? ref,
  }) : super(
         amount: amount,
         sourceIban: sourceIban,
         knownSource: knownSource,
         date: date,
         ref: ref,
       );

  factory DepositeModel.fromJson(Map<String, dynamic> json) {
    return DepositeModel(
      amount: json['amount'],
      sourceIban: json['source'],
      knownSource: json['knownSource'],
      date: json['date'],
      ref: json['ref'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'sourceIban': sourceIban,
      'knownSource': knownSource,
      'date': date,
      'ref': ref,
    };
  }
}
