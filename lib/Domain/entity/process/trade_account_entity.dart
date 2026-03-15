import 'package:equatable/equatable.dart';

class TradeAccountEntity extends Equatable {
  final num? total;
  final num? available;
  final num? reserved;
  final num? pending;
  final num? blocked;
  final num? invested;
  final num? expectedProfit;

  const TradeAccountEntity({
    this.total,
    this.available,
    this.reserved,
    this.pending,
    this.blocked,
    this.invested,
    this.expectedProfit,
  });

  @override
  List<Object?> get props => [
    total,
    available,
    reserved,
    pending,
    blocked,
    invested,
    expectedProfit,
  ];
}
