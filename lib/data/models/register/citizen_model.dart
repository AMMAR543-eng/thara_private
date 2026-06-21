import '../../../index/index_main.dart';

class CitizenResponseModel extends BaseModel {
  final CitizenModel? data;

  CitizenResponseModel({
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

  factory CitizenResponseModel.fromJson(Map<String, dynamic> json) {
    return CitizenResponseModel(
      data: json['data'] != null ? CitizenModel.fromJson(json['data']) : null,
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

class CitizenModel extends CitizenShipsEntity {
  @override
  final List<CitizenItemModel>? citizenShips;

  const CitizenModel({this.citizenShips}) : super(citizenShips: citizenShips);

  factory CitizenModel.fromJson(Map<String, dynamic> json) {
    var list = json['citizenShips'] as List?;
    List<CitizenItemModel> itemsList = list != null
        ? list.map((i) => CitizenItemModel.fromJson(i)).toList()
        : [];
    return CitizenModel(citizenShips: itemsList);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'citizenShips': citizenShips};
  }
}

class CitizenItemModel extends CitizenShipsItemEntity {
  @override
  final String? isoCode;
  @override
  final String? name;

  const CitizenItemModel({this.isoCode, this.name})
      : super(isoCode: isoCode, name: name);

  factory CitizenItemModel.fromJson(Map<String, dynamic> json) {
    return CitizenItemModel(
      isoCode: json['iso_code'] as String?,
      name: json['name'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'isoCode': isoCode, 'name': name};
  }
}
