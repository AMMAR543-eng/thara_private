class CheckPaymentResponseModel {
  final String status;
  final bool isPaid;

  CheckPaymentResponseModel({
    required this.status,
    required this.isPaid,
  });

  factory CheckPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    final status = data['status']?.toString() ?? '';

    return CheckPaymentResponseModel(
      status: status,
      isPaid: _mapStatusToPaid(status),
    );
  }

  static bool _mapStatusToPaid(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'success':
      case 'completed':
        return true;
      default:
        return false;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'is_paid': isPaid,
    };
  }
}
