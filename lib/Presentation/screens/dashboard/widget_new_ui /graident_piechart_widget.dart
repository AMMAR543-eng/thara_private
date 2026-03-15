import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../index/index_main.dart';

class MiniGreyBarChart extends StatelessWidget {
  final List<double> values;
  final double maxY;

  const MiniGreyBarChart({super.key, required this.values, this.maxY = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.border_natural_normal.withOpacity(0.2),
        ),
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          isVisible: false, // ✅ hide horizontal labels
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          interval: 10,
          minimum: 0,
          maximum: maxY,
          majorGridLines: MajorGridLines(
            color: AppColors.border_natural_normal.withValues(alpha: 0.2),
          ),
          axisLine: const AxisLine(width: 0),
          labelStyle: TextStyle(
            color: AppColors.content_secondary.withValues(alpha: 0.7),
            fontSize: 10.sp,
          ),
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<_ChartData, String>(
            dataSource: List.generate(
              values.length,
              (i) => _ChartData(i.toString(), values[i]),
            ),
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.value,
            borderRadius: BorderRadius.circular(4.r),
            color: AppColors.content_secondary.withOpacity(0.15),
            // ✅ subtle grey
            width: 0.4,
            spacing: 0.2,
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;

  _ChartData(this.label, this.value);
}
