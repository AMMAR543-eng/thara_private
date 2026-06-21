import '../../../index/index_main.dart';

class PaymentsScheduleEntity extends Equatable {
  final String? dueToDate;
  final int? monthOffset;
  final String? principle;
  final String? interest;
  final String? total;
  final String? netProfit; // e.g., صافي الربح
  final String? platformFee; // e.g., رسوم الأتعاب

  const PaymentsScheduleEntity({
    this.dueToDate,
    this.monthOffset,
    this.principle,
    this.interest,
    this.total,
    this.netProfit,
    this.platformFee,
  });

  @override
  List<Object?> get props => [
        dueToDate,
        monthOffset,
        principle,
        interest,
        total,
        netProfit,
        platformFee,
      ];
}
