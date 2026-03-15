import 'package:equatable/equatable.dart';

class InvestmentLimitationEntity extends Equatable {
  final bool? limitation;
  final num? maxAmountCanInvest;

  const InvestmentLimitationEntity({this.limitation, this.maxAmountCanInvest});

  @override
  List<Object?> get props => [limitation, maxAmountCanInvest];
}
