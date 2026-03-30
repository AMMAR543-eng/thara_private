import 'package:thara/index/index_main.dart';

class OpportunityDetailsModel extends OpportunityDetailsEntity {
  const OpportunityDetailsModel({
    final OpportunitiesItemsResponse? opportunitiesItems,
    final TradeAccount? tradeAccount,
    final InvestmentLimitationModel? investmentLimitation,
    final List<OpportunitiesItemsResponse>? relatedOpportunities,
    final int? customStatusCode,
    final String? message,
    final bool? debug,
    final String? env,
  }) : super(
          opportunitiesItems: opportunitiesItems,
          tradeAccount: tradeAccount,
          investmentLimitation: investmentLimitation,
          relatedOpportunities: relatedOpportunities,
          customStatusCode: customStatusCode,
          message: message,
          debug: debug,
          env: env,
        );

  factory OpportunityDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return OpportunityDetailsModel(
      opportunitiesItems: data?['opportunity'] != null
          ? OpportunitiesItemsResponse.fromJson(data!['opportunity'])
          : null,
      tradeAccount: data?['tradeAccount'] != null
          ? TradeAccount.fromJson(data!['tradeAccount'])
          : null,
      investmentLimitation: data?['investmentLimitation'] != null
          ? InvestmentLimitationModel.fromJson(data!['investmentLimitation'])
          : null,
      relatedOpportunities: data?['relatedOpportunities'] != null
          ? List<Map<String, dynamic>>.from(
              data!['relatedOpportunities'],
            ).map((e) => OpportunitiesItemsResponse.fromJson(e)).toList()
          : [],
      customStatusCode: json['customStatusCode'] as int?,
      message: json['message'] as String?,
      debug: json['debug'] as bool?,
      env: json['env'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'opportunity':
            (opportunitiesItems as OpportunitiesItemsResponse?)?.toJson(),
        'tradeAccount': (tradeAccount as TradeAccount?)?.toJson(),
        'investmentLimitation':
            (investmentLimitation as InvestmentLimitationModel?)?.toJson(),
        'relatedOpportunities': relatedOpportunities
            ?.map((e) => (e as OpportunitiesItemsResponse).toJson())
            .toList(),
      },
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
    };
  }
}
