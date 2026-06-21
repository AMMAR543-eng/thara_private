import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../../index/index_main.dart';

class CalendarPickerGeneralView extends StatefulWidget {
  final TextEditingController controller;

  const CalendarPickerGeneralView({super.key, required this.controller});

  @override
  State<CalendarPickerGeneralView> createState() =>
      _CalendarPickerGeneralViewState();
}

class _CalendarPickerGeneralViewState extends State<CalendarPickerGeneralView> {
  /// selected values
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.date_picker_background,
      height: 350.h,
      width: ScreenUtil().screenWidth,
      child: Column(
        children: [
          /// --- Header (تم فقط)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "done".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// --- Gregorian Picker only
          Expanded(
            child: Container(
              color: AppColors.date_picker_background.withValues(alpha: 0.8),
              child: _buildGregorianPicker(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGregorianPicker() {
    final months = List.generate(
      12,
      (i) => DateFormat.MMMM().format(DateTime(0, i + 1)),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Year
        SizedBox(
          width: 90.w,
          child: CupertinoPicker(
            itemExtent: 40.h,
            looping: true,
            scrollController: FixedExtentScrollController(
              initialItem: selectedYear - 1950,
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedYear = 1950 + index;
                _adjustDay();
              });
            },
            children: List.generate(
              100,
              (i) => Center(
                child: Text(
                  "${1950 + i}",
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.background_black,
                    fontWeight: selectedYear == 1950 + i
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),

        /// Day
        SizedBox(
          width: 70.w,
          child: CupertinoPicker(
            itemExtent: 40.h,
            looping: true,
            scrollController: FixedExtentScrollController(
              initialItem: selectedDay - 1,
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedDay = index + 1;
                _notifyDateSelected();
              });
            },
            children: List.generate(
              _daysInMonth(selectedYear, selectedMonth),
              (i) => Center(
                child: Text(
                  "${i + 1}",
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.background_black,
                    fontWeight: selectedDay == i + 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),

        /// Month
        SizedBox(
          width: 120.w,
          child: CupertinoPicker(
            itemExtent: 40.h,
            looping: true,
            scrollController: FixedExtentScrollController(
              initialItem: selectedMonth - 1,
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedMonth = index + 1;
                _adjustDay();
              });
            },
            children: months.map((m) {
              final index = months.indexOf(m) + 1;
              return Center(
                child: Text(
                  m,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.background_black,
                    fontWeight: selectedMonth == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helpers
  int _daysInMonth(int year, int month) {
    if (month == 2) {
      return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) ? 29 : 28;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }

  void _adjustDay() {
    final maxDay = _daysInMonth(selectedYear, selectedMonth);
    if (selectedDay > maxDay) selectedDay = maxDay;
    _notifyDateSelected();
  }

  void _notifyDateSelected() {
    final formatted =
        "$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}";
    widget.controller.text = formatted;
  }
}
