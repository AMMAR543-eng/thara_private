import '../../../../index/index_main.dart';

class CitizenShipsItemEntity extends Equatable {
  final String? isoCode;
  final String? name;

  const CitizenShipsItemEntity({this.isoCode, this.name});

  @override
  List<Object?> get props => [isoCode, name];
}
