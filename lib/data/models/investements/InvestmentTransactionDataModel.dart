
import '../../../index/index_main.dart';

class InvestmentTransactionDataModel extends InvestmentTransactionDataEntity {
  const InvestmentTransactionDataModel({
    final List<InvestmentTransactionItemModel>? items,
    final Pagination? meta,
  }) : super(items: items, meta: meta);

  factory InvestmentTransactionDataModel.fromJson(Map<String, dynamic> json) {
    return InvestmentTransactionDataModel(
      items: (json['items'] as List?)
          ?.map((e) => InvestmentTransactionItemModel.fromJson(e))
          .toList(),
      meta: json['meta'] != null ? Pagination.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': (items as List?)
          ?.map((e) => (e as InvestmentTransactionItemModel).toJson())
          .toList(),
      'meta': meta?.toJson(),
    };
  }
}
