import 'package:thara/index/index_main.dart';

class InvestmentLimitationModel extends InvestmentLimitationEntity {
  const InvestmentLimitationModel({
    final bool? limitation,
    final num? maxAmountCanInvest,
  }) : super(limitation: limitation, maxAmountCanInvest: maxAmountCanInvest);

  factory InvestmentLimitationModel.fromJson(Map<String, dynamic> json) {
    return InvestmentLimitationModel(
      limitation: json['limitation'] as bool?,
      maxAmountCanInvest: json['maxAmountCanInvest'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'limitation': limitation, 'maxAmountCanInvest': maxAmountCanInvest};
  }
}
