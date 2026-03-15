import '../../../index/index_main.dart';

import '../../../index/index_main.dart';

class TradeAccount extends TradeAccountEntity {
  const TradeAccount({
    num? total,
    num? available,
    num? reserved,
    num? pending,
    num? blocked,
    num? invested,
    num? expectedProfit,
  }) : super(
    total: total,
    available: available,
    reserved: reserved,
    pending: pending,
    blocked: blocked,
    invested: invested,
    expectedProfit: expectedProfit,
  );

  factory TradeAccount.fromJson(Map<String, dynamic> json) {
    return TradeAccount(
      total: json['total'],
      available: json['available'],
      reserved: json['reserved'],
      pending: json['pending'],
      blocked: json['blocked'],
      invested: json['invested'],
      expectedProfit: json['expectedProfit'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'available': available,
      'reserved': reserved,
      'pending': pending,
      'blocked': blocked,
      'invested': invested,
      'expectedProfit': expectedProfit,
    };
  }
}

class AccountResponse extends BaseModel {
  final TradeAccount? tradeAccount;

  AccountResponse({
    this.tradeAccount,
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

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      tradeAccount: json['data']?['tradeAccount'] != null
          ? TradeAccount.fromJson(json['data']['tradeAccount'])
          : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account: json['data']?['account'] != null
          ? AccountModel.fromJson(json['data']['account'])
          : null,
      user: json['data']?['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'tradeAccount': tradeAccount?.toJson(),
        'account': account?.toJson(),
        'user': user?.toJson(),
      },
      ...super.toJson(), // Spread the BaseModel's fields
    };
  }
}
