
import '../../../Domain/entity/opportunities/payments_schedule_entity.dart';

class PaymentsScheduleResponse extends PaymentsScheduleEntity {
  const PaymentsScheduleResponse({
    final String? dueToDate,
    final int? monthOffset,
    final String? principle,
    final String? interest,
    final String? total,
  }) : super(
         dueToDate: dueToDate,
         monthOffset: monthOffset,
         principle: principle,
         interest: interest,
         total: total,
       );

  factory PaymentsScheduleResponse.fromJson(Map<String, dynamic> json) {
    return PaymentsScheduleResponse(
      dueToDate: json['dueToDate'] as String?,
      monthOffset: json['monthOffset'] as int?,
      principle: json['principle'] as String?,
      interest: json['interest'] as String?,
      total: json['total'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dueToDate': dueToDate,
      'monthOffset': monthOffset,
      'principle': principle,
      'interest': interest,
      'total': total,
    };
  }
}
