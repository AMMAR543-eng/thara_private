import '../../../index/index_main.dart';

class BankAddressDataEntity {
  final List<GenericListModel>? banks;
  final bool? leanEnabled;
  final List<AddressEntity>? addresses;

  const BankAddressDataEntity({
    this.banks,
    this.leanEnabled,
    this.addresses,
  });
}

class AddressEntity {
  final String objLatLng;
  final String buildingNumber;
  final String street;
  final String district;
  final String city;
  final String postCode;
  final bool isPrimary;

  const AddressEntity({
    required this.objLatLng,
    required this.buildingNumber,
    required this.street,
    required this.district,
    required this.city,
    required this.postCode,
    required this.isPrimary,
  });
}
