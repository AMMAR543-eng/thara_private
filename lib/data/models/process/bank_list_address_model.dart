import '../../../index/index_main.dart';

class BankAccountResponseModel extends BaseModel {
  final BankAccountRespoModel? data;

  BankAccountResponseModel({
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

  factory BankAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return BankAccountResponseModel(
      data: json['data'] != null
          ? BankAccountRespoModel.fromJson(json['data'])
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

class BankAccountRespoModel extends BankAddressDataEntity {
  @override
  final List<GenericListModel>? banks;
  @override
  final bool? leanEnabled;
  @override
  final List<AddressModel>? addresses;

  BankAccountRespoModel({this.banks, this.leanEnabled, this.addresses})
      : super(banks: banks, leanEnabled: leanEnabled, addresses: addresses);

  factory BankAccountRespoModel.fromJson(Map<String, dynamic> json) {
    return BankAccountRespoModel(
      banks: (json['banks'] as List?)
          ?.map((e) => GenericListModel.fromJson(e))
          .toList(),
      leanEnabled: json['lean_enabled'],
      addresses: (json['addresses'] as List?)
          ?.map((e) => AddressModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banks': banks?.map((e) => e.toJson()).toList(),
      'lean_enabled': leanEnabled,
      'addresses': addresses?.map((e) => e.toJson()).toList(),
    };
  }
}

class BankModel extends GenericListModel {
  BankModel({required int id, required String name})
      : super(id: id, name: name);

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(id: json['id'], name: json['name']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    required String objLatLng,
    required String buildingNumber,
    required String street,
    required String district,
    required String city,
    required String postCode,
    required bool isPrimary,
  }) : super(
          objLatLng: objLatLng,
          buildingNumber: buildingNumber,
          street: street,
          district: district,
          city: city,
          postCode: postCode,
          isPrimary: isPrimary,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      objLatLng: json['obj_lat_lng'],
      buildingNumber: json['building_number'],
      street: json['street'],
      district: json['district'],
      city: json['city'],
      postCode: json['post_code'],
      isPrimary: json['is_primary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'obj_lat_lng': objLatLng,
      'building_number': buildingNumber,
      'street': street,
      'district': district,
      'city': city,
      'post_code': postCode,
      'is_primary': isPrimary,
    };
  }
}
