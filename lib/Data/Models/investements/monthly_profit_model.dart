import '../../../index/index_main.dart';

class ProfitSummaryResponseModel extends BaseModel {
  final ProfitSummaryDataModel? data;

  ProfitSummaryResponseModel({
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

  factory ProfitSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfitSummaryResponseModel(
      data: json['data'] != null
          ? ProfitSummaryDataModel.fromJson(json['data'])
          : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'data': data?.toJson(), ...super.toJson()};
  }
}

class ProfitSummaryDataModel {
  final List<num>? monthlyExpectedProfit;
  final List<num>? monthlyGainedProfit;
  final List<num>? monthlyDefaultProfit;
  final List<num>? monthlyOverdueProfit; // ✅ NEW FIELD
  final String? minYear;
  final String? maxYear;

  ProfitSummaryDataModel({
    this.monthlyExpectedProfit,
    this.monthlyGainedProfit,
    this.monthlyDefaultProfit,
    this.monthlyOverdueProfit, // ✅ NEW
    this.minYear,
    this.maxYear,
  });

  factory ProfitSummaryDataModel.fromJson(Map<String, dynamic> json) {
    return ProfitSummaryDataModel(
      monthlyExpectedProfit: json['monthlyExpectedProfit'] != null
          ? List<num>.from(json['monthlyExpectedProfit'])
          : [],
      monthlyGainedProfit: json['monthlyGainedProfit'] != null
          ? List<num>.from(json['monthlyGainedProfit'])
          : [],
      monthlyDefaultProfit: json['monthlyDefaultProfit'] != null
          ? List<num>.from(json['monthlyDefaultProfit'])
          : [],
      monthlyOverdueProfit: json['monthlyOverdueProfit'] != null          // ✅ NEW
          ? List<num>.from(json['monthlyOverdueProfit'])                  // ✅ NEW
          : [],                                                            // ✅ NEW
      minYear: json['minYear'],
      maxYear: json['maxYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monthlyExpectedProfit': monthlyExpectedProfit ?? [],
      'monthlyGainedProfit': monthlyGainedProfit ?? [],
      'monthlyDefaultProfit': monthlyDefaultProfit ?? [],
      'monthlyOverdueProfit': monthlyOverdueProfit ?? [], // ✅ NEW
      'minYear': minYear,
      'maxYear': maxYear,
    };
  }
}

