class CompanyParam {
  final String name;
  final String fieldOfBusiness;
  final String crn;
  final String unifiedNumber;
  final String citizenship;
  final String phoneNumber;
  final String nin;
  final String dob;

  CompanyParam({
    required this.name,
    required this.fieldOfBusiness,
    required this.crn,
    required this.unifiedNumber,
    required this.citizenship,
    required this.phoneNumber,
    required this.nin,
    required this.dob,
  });

  factory CompanyParam.fromJson(Map<String, dynamic> json) {
    return CompanyParam(
      name: json['name'] ?? '',
      fieldOfBusiness: json['field_of_business'] ?? '',
      crn: json['crn'] ?? '',
      unifiedNumber: json['unified_number'] ?? '',
      citizenship: json['citizenship'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      nin: json['nin'] ?? '',
      dob: json['dob'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'citizenship': citizenship,
        'phone_number': phoneNumber,
        'nin': nin,
        'dob': dob,
      },
      'company': {
        'name': name,
        'field_of_business': fieldOfBusiness,
        'crn': crn,
        'unified_number': unifiedNumber,
      },
    };
  }
}
