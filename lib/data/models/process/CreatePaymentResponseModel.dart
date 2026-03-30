class CreatePaymentResponseModel {
  final String reference;

  CreatePaymentResponseModel({required this.reference});

  factory CreatePaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePaymentResponseModel(
      reference: json['data']['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'reference': reference,
      }
    };
  }
}
