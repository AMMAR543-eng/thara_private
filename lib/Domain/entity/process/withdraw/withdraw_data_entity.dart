import '../../../../index/index_main.dart';

class WithdrawDataEntity extends Equatable {
  final List<WithdrawEntity>? items;
  final MetaEntity? meta;

  const WithdrawDataEntity({this.items, this.meta});

  @override
  List<Object?> get props => [items, meta];
}
