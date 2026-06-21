import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../index/index_main.dart';
import 'graident_piechart_widget.dart';

class ProfitChartWidget extends StatefulWidget {
  final ProfitSummaryDataModel? profitSummaryDataModel;

  const ProfitChartWidget({super.key, required this.profitSummaryDataModel});

  @override
  State<ProfitChartWidget> createState() => _ProfitChartWidgetState();
}

class _ProfitChartWidgetState extends State<ProfitChartWidget>
    with SingleTickerProviderStateMixin {
  bool _animate = false;
  late AnimationController _controller;
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    final maxYear = int.tryParse(widget.profitSummaryDataModel?.maxYear ?? "");
    if (maxYear != null) selectedYear = maxYear;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.profitSummaryDataModel;

    if (data == null ||
        data.monthlyExpectedProfit == null ||
        data.monthlyExpectedProfit!.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "monthly_profits".tr,
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_primary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          const MiniGreyBarChart(
            values: [85, 70, 60, 55, 50, 45, 42, 38, 30, 25],
            maxY: 100,
          ),
        ],
      );
    }

    /// ----------------------------
    /// Build chart data for 12 months
    /// ----------------------------
    final List<_MonthlyProfit> chartData = List.generate(12, (index) {
      final expected = data.monthlyExpectedProfit?.elementAtOrNull(index) ?? 0;
      final gained = data.monthlyGainedProfit?.elementAtOrNull(index) ?? 0;
      final delayed = data.monthlyDefaultProfit?.elementAtOrNull(index) ?? 0;
      final overdue = data.monthlyOverdueProfit?.elementAtOrNull(index) ?? 0;

      return _MonthlyProfit(
        month: index + 1,
        expected: expected.toDouble(),
        gained: gained.toDouble(),
        delayed: delayed.toDouble(),
        overdue: overdue.toDouble(),
      );
    });

    return VisibilityDetector(
      key: const Key("profit_chart"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_animate) {
          setState(() => _animate = true);
          _controller.forward(from: 0);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ----------------------------
          /// Header with year selector
          /// ----------------------------
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "monthly_profits".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: _openYearSelector,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border_default),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedYear.toString(),
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.content_primary,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.content_primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ----------------------------
          /// Chart Box
          /// ----------------------------
          Container(
            height: 320.h,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SfCartesianChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: context.typography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
              plotAreaBorderWidth: 0,

              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: context.typography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
                axisLine: const AxisLine(width: 0),
              ),

              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
                labelStyle: context.typography.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
                numberFormat: NumberFormat.decimalPattern(),
              ),

              /// ----------------------------
              /// Profit Series with Colors
              /// ----------------------------
              series: <CartesianSeries<_MonthlyProfit, String>>[
                // 🟦 Expected (الأرباح المتوقعة)
                ColumnSeries<_MonthlyProfit, String>(
                  dataSource: chartData,
                  xValueMapper: (d, _) => _monthNameArabic(d.month),
                  yValueMapper: (d, _) => d.expected,
                  name: "profit_expected".tr,
                  color: const Color(0xFF2A7F78),
                  borderRadius: BorderRadius.circular(6.r),
                  animationDuration: 1200,
                ),

                // 🟢 Gained (الأرباح المحصلة)
                ColumnSeries<_MonthlyProfit, String>(
                  dataSource: chartData,
                  xValueMapper: (d, _) => _monthNameArabic(d.month),
                  yValueMapper: (d, _) => d.gained,
                  name: "profit_gained".tr,
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(6.r),
                  animationDuration: 1200,
                ),

                // 🟡 Delayed (الأرباح المتأخرة)
                ColumnSeries<_MonthlyProfit, String>(
                  dataSource: chartData,
                  xValueMapper: (d, _) => _monthNameArabic(d.month),
                  yValueMapper: (d, _) => d.delayed,
                  name: "profit_delayed".tr,
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(6.r),
                  animationDuration: 1200,
                ),

                // 🟠 Default (الأرباح المتعثرة)
                ColumnSeries<_MonthlyProfit, String>(
                  dataSource: chartData,
                  xValueMapper: (d, _) => _monthNameArabic(d.month),
                  yValueMapper: (d, _) => d.overdue,
                  name: "profit_default".tr,
                  color: const Color(0xFFE67E22),
                  borderRadius: BorderRadius.circular(6.r),
                  animationDuration: 1200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Arabic month names
  String _monthNameArabic(int month) {
    const months = [
      "january",
      "february",
      "march",
      "april",
      "may",
      "june",
      "july",
      "august",
      "september",
      "october",
      "november",
      "december",
    ];
    return months[month - 1].tr;
  }

  /// ----------------------------
  /// FIXED YEAR SELECTOR 🔥
  /// ----------------------------
  void _openYearSelector() {
    final data = widget.profitSummaryDataModel;

    final int? minYear = int.tryParse(data?.minYear ?? "");
    final int? maxYear = int.tryParse(data?.maxYear ?? "");

    List<int> years = [];

    if (minYear != null && maxYear != null) {
      for (int y = minYear; y <= maxYear; y++) {
        years.add(y);
      }
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        if (years.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.content_secondary,
                    size: 40.w,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "no_years_available".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.content_secondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 80.h, top: 20),
          itemCount: years.length,
          itemBuilder: (_, i) {
            final y = years[i];
            return ListTile(
              title: Text(
                y.toString(),
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              trailing: selectedYear == y
                  ? Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() => selectedYear = y);
                Navigator.pop(context);
                _controller.forward(from: 0);
              },
            );
          },
        );
      },
    );
  }
}

/// Helper model
class _MonthlyProfit {
  final int month;
  final double expected;
  final double gained;
  final double delayed;
  final double overdue;

  _MonthlyProfit({
    required this.month,
    this.expected = 0,
    this.gained = 0,
    this.delayed = 0,
    this.overdue = 0,
  });
}
