import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../../index/index_main.dart';

class CalendarPickerView extends StatefulWidget {
  final TextEditingController controller;
  final RegisterInfoController? getxController;

  const CalendarPickerView({
    super.key,
    required this.controller,
    this.getxController,
  });

  @override
  State<CalendarPickerView> createState() => _CalendarPickerViewState();
}

class _CalendarPickerViewState extends State<CalendarPickerView> {
  int calendarTypeIndex = 1; // 0 = Gregorian, 1 = Hijri

  /// stateful selected values
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  int selectedHijriYear = 1445;
  int selectedHijriMonth = 1;
  int selectedHijriDay = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.date_picker_background,
      height: 350.h,
      width: ScreenUtil().screenWidth,
      child: Column(
        children: [
          /// --- Header (تم + Segmented Control)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Done button (تم)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "done".tr, // 🔑 add to localization
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // /// Segmented Control (ميلادي/هجري)
                // CupertinoSegmentedControl<int>(
                //   groupValue: calendarTypeIndex,
                //   selectedColor: AppColors.white,
                //   unselectedColor: AppColors.greyDark,
                //   borderColor: AppColors.greyDark,
                //
                //   children: {
                //     0: Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 10,
                //         vertical: 5,
                //       ),
                //       child: Text(
                //         "gregorian".tr,
                //         style: context.typography.bodyLarge.copyWith(
                //           color: AppColors.primary,
                //         ),
                //       ),
                //     ),
                //     1: Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 10,
                //         vertical: 5,
                //       ),
                //       child: Text(
                //         "hijri".tr,
                //         style: context.typography.bodyLarge.copyWith(
                //           color: AppColors.primary,
                //         ),
                //       ),
                //     ),
                //   },
                //   onValueChanged: (index) {
                //     setState(() {
                //       calendarTypeIndex = index;
                //     });
                //   },
                // ),
              ],
            ),
          ),

          /// --- Body
          Expanded(
            child: calendarTypeIndex == 0
                ? Container(
                    color: AppColors.date_picker_background.withValues(
                      alpha: 0.8,
                    ),
                    child: _buildGregorianPicker(),
                  )
                : Container(
                    color: AppColors.date_picker_background.withValues(
                      alpha: 0.65,
                    ),
                    child: _buildHijriPicker(),
                  ),
          ),
        ],
      ),
    );
  }

  /// Gregorian Picker
  Widget _buildGregorianPicker() {
    final months = List.generate(
      12,
      (i) => DateFormat.MMMM().format(DateTime(0, i + 1)),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        // /// highlight container (center row across all pickers)
        // Positioned.fill(
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Container(
        //       height: 40.h, // same as itemExtent
        //       margin: const EdgeInsets.symmetric(horizontal: 8),
        //       decoration: BoxDecoration(
        //         color: Colors.black.withValues(alpha: 0.45),
        //         // subtle grey highlight
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //     ),
        //   ),
        // ),

        /// pickers row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ],
    );
  }

  /// Hijri Picker
  Widget _buildHijriPicker() {
    final months = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        /// pickers row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Year
            SizedBox(
              width: 90.w,
              child: CupertinoPicker(
                itemExtent: 40.h,
                looping: true,
                scrollController: FixedExtentScrollController(
                  initialItem: selectedHijriYear - 1350,
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedHijriYear = 1350 + index;
                    _adjustHijriDay();
                  });
                },
                children: List.generate(150, (i) {
                  final year = 1350 + i;
                  return Center(
                    child: Text(
                      "$year",
                      style: context.typography.headerXLarge.copyWith(
                        color: AppColors.background_black,
                        fontWeight: selectedHijriYear == year
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }),
              ),
            ),

            /// Day
            SizedBox(
              width: 70.w,
              child: CupertinoPicker(
                itemExtent: 40.h,
                looping: true,
                scrollController: FixedExtentScrollController(
                  initialItem: selectedHijriDay - 1,
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedHijriDay = index + 1;
                    _notifyHijriSelected();
                  });
                },
                children: List.generate(30, (i) {
                  final day = i + 1;
                  return Center(
                    child: Text(
                      "$day",
                      style: context.typography.headerXLarge.copyWith(
                        color: AppColors.background_black,
                        fontWeight: selectedHijriDay == day
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }),
              ),
            ),

            /// Month
            SizedBox(
              width: 120.w,
              child: CupertinoPicker(
                itemExtent: 40.h,
                looping: true,
                scrollController: FixedExtentScrollController(
                  initialItem: selectedHijriMonth - 1,
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedHijriMonth = index + 1;
                    _adjustHijriDay();
                  });
                },
                children: months.map((m) {
                  final index = months.indexOf(m) + 1;
                  return Center(
                    child: Text(
                      m,
                      style: context.typography.headerXLarge.copyWith(
                        color: AppColors.background_black,
                        fontWeight: selectedHijriMonth == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
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

  void _adjustHijriDay() {
    if (selectedHijriDay > 30) selectedHijriDay = 30;
    _notifyHijriSelected();
  }

  void _notifyDateSelected() {
    final formatted =
        "$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}";
    widget.controller.text = formatted;
    widget.getxController?.handleGregorianDateSelected(formatted);
    widget.getxController?.update();
  }

  void _notifyHijriSelected() {
    final formatted =
        "$selectedHijriYear-${selectedHijriMonth.toString().padLeft(2, '0')}-${selectedHijriDay.toString().padLeft(2, '0')}";
    widget.controller.text = formatted;
    widget.getxController?.hijriEquivalent = null;
    widget.getxController?.update();
  }
}
