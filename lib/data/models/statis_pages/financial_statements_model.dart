class FinancialStatementsResponseModel {
  final FinancialStatementsData? data;
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;

  FinancialStatementsResponseModel({
    this.data,
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
  });

  factory FinancialStatementsResponseModel.fromJson(Map<String, dynamic> json) {
    return FinancialStatementsResponseModel(
      data: json['data'] != null
          ? FinancialStatementsData.fromJson(json['data'])
          : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
    };
  }
}

class FinancialStatementsData {
  final List<FinancialStatementItem>? financialStatements;

  FinancialStatementsData({this.financialStatements});

  factory FinancialStatementsData.fromJson(Map<String, dynamic> json) {
    return FinancialStatementsData(
      financialStatements: (json['financialStatements'] as List<dynamic>?)
          ?.map((e) => FinancialStatementItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'financialStatements':
      financialStatements?.map((e) => e.toJson()).toList(),
    };
  }
}

class FinancialStatementItem {
  final String? year;
  final String? quarter;
  final String? attachment;

  FinancialStatementItem({this.year, this.quarter, this.attachment});

  factory FinancialStatementItem.fromJson(Map<String, dynamic> json) {
    return FinancialStatementItem(
      year: json['year'],
      quarter: json['quarter'],
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'quarter': quarter,
      'attachment': attachment,
    };
  }
}
