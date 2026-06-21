import '../../../index/index_main.dart';

class InvestmentTransactionDataEntity extends Equatable {
  final List<InvestmentTransactionItemEntity>? items;
  final Pagination? meta;

  const InvestmentTransactionDataEntity({this.items, this.meta});

  @override
  List<Object?> get props => [items, meta];
}
