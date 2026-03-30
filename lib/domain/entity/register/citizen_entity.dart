import '../../../../index/index_main.dart';

class CitizenShipsEntity extends Equatable {
  final List<CitizenShipsItemEntity>? citizenShips;

  const CitizenShipsEntity({this.citizenShips});

  @override
  List<Object?> get props => [citizenShips];
}
