// class CheckPaymentResponseModel {
//   final String paymentId;
//   final String status;
//   final bool isPaid;
//   final String? message;
//   final double? amount;
//   final String? paymentType;
//
//   CheckPaymentResponseModel({
//     required this.paymentId,
//     required this.status,
//     required this.isPaid,
//     this.message,
//     this.amount,
//     this.paymentType,
//   });
//
//   factory CheckPaymentResponseModel.fromJson(Map<String, dynamic> json) {
//     final status = json['status']?.toString() ?? '';
//
//     return CheckPaymentResponseModel(
//       paymentId: json['payment_id'] ?? json['id'] ?? '',
//       status: status,
//       isPaid: _mapStatusToPaid(status, json),
//       message: json['message'],
//       amount: json['payment_amount'] != null
//           ? double.tryParse(json['payment_amount'].toString())
//           : null,
//       paymentType: json['payment_type'],
//     );
//   }
//
//   static bool _mapStatusToPaid(String status, Map<String, dynamic> json) {
//     // لو backend بيرجع flag صريح
//     if (json.containsKey('is_paid')) {
//       return json['is_paid'] == true;
//     }
//
//     // fallback على status
//     switch (status.toLowerCase()) {
//       case 'paid':
//       case 'success':
//       case 'completed':
//         return true;
//       default:
//         return false;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'payment_id': paymentId,
//       'status': status,
//       'is_paid': isPaid,
//       'payment_amount': amount,
//       'payment_type': paymentType,
//       'message': message,
//     };
//   }
// }
