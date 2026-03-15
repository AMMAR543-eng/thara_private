class QualifiedInvestorParam {
  final String? transactionHistoryRequirement; // ملف إثبات السجل المالي
  final String? netAssetRequirement; // ملف صافي الأصول
  final String? experienceInFinancialSector; // ملف خبرة بالقطاع المالي
  final String? professionalCertificationRequirement; // ملف شهادة مهنية
  final String?
  annualIncomeAndGeneralSecuritiesCertificationRequirement; // ملف الدخل السنوي

  QualifiedInvestorParam({
    this.transactionHistoryRequirement,
    this.netAssetRequirement,
    this.experienceInFinancialSector,
    this.professionalCertificationRequirement,
    this.annualIncomeAndGeneralSecuritiesCertificationRequirement,
  });

  QualifiedInvestorParam copyWith({
    String? transactionHistoryRequirement,
    String? netAssetRequirement,
    String? experienceInFinancialSector,
    String? professionalCertificationRequirement,
    String? annualIncomeAndGeneralSecuritiesCertificationRequirement,
  }) {
    return QualifiedInvestorParam(
      transactionHistoryRequirement:
          transactionHistoryRequirement ?? this.transactionHistoryRequirement,
      netAssetRequirement: netAssetRequirement ?? this.netAssetRequirement,
      experienceInFinancialSector:
          experienceInFinancialSector ?? this.experienceInFinancialSector,
      professionalCertificationRequirement:
          professionalCertificationRequirement ??
          this.professionalCertificationRequirement,
      annualIncomeAndGeneralSecuritiesCertificationRequirement:
          annualIncomeAndGeneralSecuritiesCertificationRequirement ??
          this.annualIncomeAndGeneralSecuritiesCertificationRequirement,
    );
  }
}

class QualifiedInvestorParamsWrapper {
  final QualifiedInvestorParam param;

  QualifiedInvestorParamsWrapper({required this.param});

  /// Only returns file paths (not JSON) for multipart/form-data
  Map<String, String> get files {
    final Map<String, String> fileMap = {};

    if (param.transactionHistoryRequirement != null) {
      fileMap['transactionHistoryRequirement'] =
          param.transactionHistoryRequirement!;
    }

    if (param.netAssetRequirement != null) {
      fileMap['netAssetRequirement'] = param.netAssetRequirement!;
    }

    if (param.experienceInFinancialSector != null) {
      fileMap['experienceInFinancialSector'] =
          param.experienceInFinancialSector!;
    }

    if (param.professionalCertificationRequirement != null) {
      fileMap['professionalCertificationRequirement'] =
          param.professionalCertificationRequirement!;
    }

    if (param.annualIncomeAndGeneralSecuritiesCertificationRequirement !=
        null) {
      fileMap['annualIncomeAndGeneralSecuritiesCertificationRequirement'] =
          param.annualIncomeAndGeneralSecuritiesCertificationRequirement!;
    }

    return fileMap;
  }
}
