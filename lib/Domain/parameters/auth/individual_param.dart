class IndividualParam {
  final String citizenship;
  final String phoneNumber;
  final String nin;
  final String dob;

  IndividualParam({
    required this.citizenship,
    required this.phoneNumber,
    required this.nin,
    required this.dob,
  });

  factory IndividualParam.fromJson(Map<String, dynamic> json) {
    return IndividualParam(
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
    };
  }
}
