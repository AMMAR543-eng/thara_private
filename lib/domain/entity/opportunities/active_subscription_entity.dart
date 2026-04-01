import '../../../index/index_main.dart';

class ActiveSubscriptionEntity extends Equatable {
  final String? id;
  final String? status;
  final int? volume;
  final int? price;
  final int? totalPrice;
  final int? expectedProfit;
  final int? taxesFees;
  final int? netProfit;
  final int? gainedNetProfit;
  final String? createdAt;
  final String? projectName;
  final String? loanType;
  final int? duration;
  final String? opportunityId;

  const ActiveSubscriptionEntity({
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
