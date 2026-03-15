import '../../../index/index_main.dart';

class InvestmentTransactionItemModel extends InvestmentTransactionItemEntity {
  const InvestmentTransactionItemModel({
    super.id,
    super.status,
    super.volume,
    super.price,
    super.totalPrice,
    super.expectedProfit,
    super.taxesFees,
    super.netProfit,
    super.gainedNetProfit,
    super.createdAt,
    super.projectName,
    super.loanType,
    super.duration,
    super.opportunityId,
  });

  factory InvestmentTransactionItemModel.fromJson(Map<String, dynamic> json) {
    return InvestmentTransactionItemModel(
      id: json['id'],
      status: json['status'],
      volume: json['volume'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      expectedProfit: json['expected_profit'],
      taxesFees: json['taxes_fees'],
      netProfit: json['net_profit'],
      gainedNetProfit: json['gained_net_profit'],
      createdAt: json['created_at'],
      projectName: json['projectName'],
      loanType: json['loanType'],
      duration: json['duration'],
      opportunityId: json['opportunityId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'volume': volume,
      'price': price,
      'totalPrice': totalPrice,
      'expected_profit': expectedProfit,
      'taxes_fees': taxesFees,
      'net_profit': netProfit,
      'gained_net_profit': gainedNetProfit,
      'created_at': createdAt,
      'projectName': projectName,
      'loanType': loanType,
      'duration': duration,
      'opportunityId': opportunityId,
    };
  }
}
