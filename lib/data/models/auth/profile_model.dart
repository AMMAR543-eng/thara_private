import '../../../index/index_main.dart';

class UserInfoModel extends BaseEntity {
  final PersonalInfo? personalInfo;
  final List<CompanyInfo>? companyInfo;
  final num? investmentLimitation;
  final num? activeInvestmentBalance;

  const UserInfoModel({
    super.customStatusCode,
    super.message,
    super.debug,
    super.env,
    super.account,
    super.user,
    this.personalInfo,
    this.companyInfo,
    this.investmentLimitation,
    this.activeInvestmentBalance,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return UserInfoModel(
      customStatusCode: json['customStatusCode'] as int?,
      message: json['message'] as String?,
      debug: json['debug'] as bool?,
      env: json['env'] as String?,
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      personalInfo: data?['personalInfo'] != null
          ? PersonalInfo.fromJson(data!['personalInfo'])
          : null,
      companyInfo: (data?['companyInfo'] as List?)
          ?.map((e) => CompanyInfo.fromJson(e))
          .toList(),
      investmentLimitation: data?['investmentLimitation'] as num?,
      activeInvestmentBalance: data?['activeInvestmentBalance'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
      'account': account,
      'user': user,
      'data': {
        'personalInfo': personalInfo?.toJson(),
        'companyInfo': companyInfo?.map((e) => e.toJson()).toList(),
        'investmentLimitation': investmentLimitation,
        'activeInvestmentBalance': activeInvestmentBalance,
      },
    };
  }
}

class PersonalInfo {
  final String? fullNameAr;
  final String? fullNameEn;
  final String? sex;
  final String? dateOfBirthG;
  final String? dateOfBirthH;
  final String? idExpiryDate;

  const PersonalInfo({
    this.fullNameAr,
    this.fullNameEn,
    this.sex,
    this.dateOfBirthG,
    this.dateOfBirthH,
    this.idExpiryDate,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        fullNameAr: json['fullNameAr'] as String?,
        fullNameEn: json['fullNameEn'] as String?,
        sex: json['sex'] as String?,
        dateOfBirthG: json['dateOfBirthG'] as String?,
        dateOfBirthH: json['dateOfBirthH'] as String?,
        idExpiryDate: json['idExpiryDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'fullNameAr': fullNameAr,
        'fullNameEn': fullNameEn,
        'sex': sex,
        'dateOfBirthG': dateOfBirthG,
        'dateOfBirthH': dateOfBirthH,
        'idExpiryDate': idExpiryDate,
      };
}

class CompanyInfo {
  final String? key;
  final String? value;

  const CompanyInfo({this.key, this.value});

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        key: json['key'] as String?,
        value: json['value'] as String?,
      );

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}
