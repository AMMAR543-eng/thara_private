import 'package:hijri/hijri_calendar.dart';
import 'package:thara/index/index_main.dart';

class HijriDatePicker extends StatefulWidget {
  final ValueChanged<String> onDateSelected;
  final bool? hasValue;

  const HijriDatePicker({Key? key, required this.onDateSelected, this.hasValue})
    : super(key: key);

  @override
  State<HijriDatePicker> createState() => _HijriDatePickerState();
}

class _HijriDatePickerState extends State<HijriDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  // RIGHT ✅
  List<String> get hijriMonths => [
    "hijri_muharram".tr,
    "hijri_safar".tr,
    "hijri_rabi_al_awwal".tr,
    "hijri_rabi_al_thani".tr,
    "hijri_jumada_al_ula".tr,
    "hijri_jumada_al_thania".tr,
    "hijri_rajab".tr,
    "hijri_shaban".tr,
    "hijri_ramadan".tr,
    "hijri_shawwal".tr,
    "hijri_dhul_qidah".tr,
    "hijri_dhul_hijjah".tr,
  ];

  final List<int> hijriYears = List.generate(
    100,
    (i) => 1350 + i,
  ); // from 1350 to 1450

  @override
  void initState() {
    super.initState();
    final today = HijriCalendar.now();
    selectedDay = today.hDay;
    selectedMonth = today.hMonth;
    selectedYear = today.hYear;
  }

  List<int> get hijriDays {
    final temp = HijriCalendar();
    final gregorian = temp.hijriToGregorian(selectedYear, selectedMonth, 1);
    temp.gregorianToHijri(gregorian.year, gregorian.month, gregorian.day);

    return List.generate(temp.lengthOfMonth, (i) => i + 1);
  }

  String _formattedDate() {
    return '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}';
  }

  void _notifyDateSelected() {
    widget.onDateSelected(_formattedDate());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            // InkWell(
            //   onTap: () {
            //     if (widget.hasValue != true) {
            //       WidgetsBinding.instance.addPostFrameCallback((_) {
            //         _notifyDateSelected();
            //       });
            //     }
            //     Navigator.pop(context);
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 10),
            //     alignment: Alignment.centerRight,
            //     color: Colors.grey.shade200,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       child: Text(
            //         "تم",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.green,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Row(
                children: [
                  _buildPicker(hijriYears, selectedYear, (val) {
                    setState(() {
                      selectedYear = val;
                      _adjustSelectedDay();
                    });
                  }),
                  _buildPicker(hijriMonths, hijriMonths[selectedMonth - 1], (
                    val,
                  ) {
                    setState(() {
                      selectedMonth = hijriMonths.indexOf(val) + 1;
                      _adjustSelectedDay();
                    });
                  }),
                  _buildPicker(hijriDays, selectedDay, (val) {
                    setState(() {
                      selectedDay = val;
                      _notifyDateSelected();
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker<T>(List<T> items, T selected, ValueChanged<T> onChange) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 35,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(
          initialItem: items.indexOf(selected),
        ),
        onSelectedItemChanged: (index) => onChange(items[index]),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) {
            final isSelected = items[index] == selected;
            return Center(
              child: Text(
                items[index].toString(),
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: isSelected ? 18 : 14,
                  color: isSelected ? Colors.green : Colors.black54,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _adjustSelectedDay() {
    final daysInMonth = hijriDays.length;
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
    }
    _notifyDateSelected();
  }
}
