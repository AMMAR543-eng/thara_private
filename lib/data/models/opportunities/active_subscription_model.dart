import 'package:thara/index/index_main.dart';

class ActiveSubscriptionResponse extends ActiveSubscriptionEntity {
  const ActiveSubscriptionResponse({
    final String? id,
    final String? status,
    final int? volume,
    final int? price,
    final int? totalPrice,
    final int? expectedProfit,
    final int? taxesFees,
    final int? netProfit,
    final int? gainedNetProfit,
    final String? createdAt,
    final String? projectName,
    final String? loanType,
    final int? duration,
    final String? opportunityId,
  }) : super(
          id: id,
          status: status,
          volume: volume,
          price: price,
          totalPrice: totalPrice,
          expectedProfit: expectedProfit,
          taxesFees: taxesFees,
          netProfit: netProfit,
          gainedNetProfit: gainedNetProfit,
          createdAt: createdAt,
          projectName: projectName,
          loanType: loanType,
          duration: duration,
          opportunityId: opportunityId,
        );

  factory ActiveSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return ActiveSubscriptionResponse(
      id: json['id'] as String?,
      status: json['status'] as String?,
      volume: json['volume'] as int?,
      price: json['price'] as int?,
      totalPrice: json['totalPrice'] as int?,
      expectedProfit: json['expectedProfit'] as int?,
      taxesFees: json['taxesFees'] as int?,
      netProfit: json['netProfit'] as int?,
      gainedNetProfit: json['gainedNetProfit'] as int?,
      createdAt: json['createdAt'] as String?,
      projectName: json['projectName'] as String?,
      loanType: json['loanType'] as String?,
      duration: json['duration'] as int?,
      opportunityId: json['opportunityId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'volume': volume,
      'price': price,
      'totalPrice': totalPrice,
      'expectedProfit': expectedProfit,
      'taxesFees': taxesFees,
      'netProfit': netProfit,
      'gainedNetProfit': gainedNetProfit,
      'createdAt': createdAt,
      'projectName': projectName,
      'loanType': loanType,
      'duration': duration,
      'opportunityId': opportunityId,
    };
  }
}
