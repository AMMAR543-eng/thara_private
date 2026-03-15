import 'package:equatable/equatable.dart';

class InvestmentTransactionItemEntity extends Equatable {
  final String? id;
  final String? status;
  final num? volume;
  final num? price;
  final num? totalPrice;
  final num? expectedProfit;
  final num? taxesFees;
  final num? netProfit;
  final num? gainedNetProfit;
  final String? createdAt;
  final String? projectName;
  final String? loanType;
  final num? duration;
  final String? opportunityId;

  const InvestmentTransactionItemEntity({
    this.id,
    this.status,
    this.volume,
    this.price,
    this.totalPrice,
    this.expectedProfit,
    this.taxesFees,
    this.netProfit,
    this.gainedNetProfit,
    this.createdAt,
    this.projectName,
    this.loanType,
    this.duration,
    this.opportunityId,
  });

  @override
  List<Object?> get props => [
    id,
    status,
    volume,
    price,
    totalPrice,
    expectedProfit,
    taxesFees,
    netProfit,
    gainedNetProfit,
    createdAt,
    projectName,
    loanType,
    duration,
    opportunityId,
  ];
}
