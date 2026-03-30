
import '../../../index/index_main.dart';

class InvestmentConfigResponseModel extends BaseModel {
  final InvestmentConfigDataModel? data;

  InvestmentConfigResponseModel({
    this.data,
    int? customStatusCode,
    String? message,
    bool? debug,
    String? env,
    AccountModel? account,
    UserModel? user,
  }) : super(
    customStatusCode: customStatusCode,
    message: message,
    debug: debug,
    env: env,
    account: account,
    user: user,
  );

  factory InvestmentConfigResponseModel.fromJson(Map<String, dynamic> json) {
    return InvestmentConfigResponseModel(
      data: json['data'] != null
          ? InvestmentConfigDataModel.fromJson(json['data'])
          : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      ...super.toJson(),
    };
  }
}


class InvestmentConfigDataModel {
  final bool? configured;
  final InvestmentConfigModel? config;

  InvestmentConfigDataModel({
    this.configured,
    this.config,
  });

  factory InvestmentConfigDataModel.fromJson(Map<String, dynamic> json) {
    return InvestmentConfigDataModel(
      configured: json['configured'],
      config: json['config'] != null
          ? InvestmentConfigModel.fromJson(json['config'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'configured': configured,
      'config': config?.toJson(),
    };
  }
}


class InvestmentConfigModel {
  final int? minInvestAmount;
  final int? maxInvestAmount;
  final bool? active;
  final List<String>? opportunityTypes;
  final List<String>? creditRatings;
  final List<String>? durations;

  InvestmentConfigModel({
    this.minInvestAmount,
    this.maxInvestAmount,
    this.active,
    this.opportunityTypes,
    this.creditRatings,
    this.durations,
  });

  factory InvestmentConfigModel.fromJson(Map<String, dynamic> json) {
    return InvestmentConfigModel(
      minInvestAmount: json['min_invest_amount'],
      maxInvestAmount: json['max_invest_amount'],
      active: json['active'],
      opportunityTypes:
      (json['opportunityTypes'] as List?)?.map((e) => e.toString()).toList(),
      creditRatings:
      (json['creditRatings'] as List?)?.map((e) => e.toString()).toList(),
      durations:
      (json['durations'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min_invest_amount': minInvestAmount,
      'max_invest_amount': maxInvestAmount,
      'active': active,
      'opportunityTypes': opportunityTypes,
      'creditRatings': creditRatings,
      'durations': durations,
    };
  }
}
