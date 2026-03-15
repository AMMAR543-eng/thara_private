import 'package:equatable/equatable.dart';
import '../process/trade_account_entity.dart';
import 'investment_limitation_entity.dart';
import 'opportunities_item_entity.dart';

class OpportunityDetailsEntity extends Equatable {
  final OpportunitiesItemsEntity? opportunitiesItems;
  final TradeAccountEntity? tradeAccount;
  final InvestmentLimitationEntity? investmentLimitation;
  final List<OpportunitiesItemsEntity>? relatedOpportunities;
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;

  const OpportunityDetailsEntity({
    this.opportunitiesItems,
    this.tradeAccount,
    this.investmentLimitation,
    this.relatedOpportunities,
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    opportunitiesItems,
    tradeAccount,
    investmentLimitation,
    relatedOpportunities,
    customStatusCode,
    message,
    debug,
    env,
  ];
}
