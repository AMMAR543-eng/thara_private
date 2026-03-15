import 'package:thara/Domain/entity/process/deposite/deposite_entity.dart';
import '../../../../index/index_main.dart';

class DepositeDataEntity extends Equatable {
  final List<DepositeEntity>? items;
  final MetaEntity? meta;

  const DepositeDataEntity({this.items, this.meta});

  @override
  List<Object?> get props => [items, meta];
}
