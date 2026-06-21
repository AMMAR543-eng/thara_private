import '../../../../index/index_main.dart';

class GenericDatePicker extends StatefulWidget {
  final ValueChanged<String> onDateSelected;
  final bool? hasValue;

  const GenericDatePicker({
    Key? key,
    required this.onDateSelected,
    this.hasValue,
  }) : super(key: key);

  @override
  _GenericDatePickerState createState() => _GenericDatePickerState();
}

class _GenericDatePickerState extends State<GenericDatePicker> {
  late int selectedDay;
  late String selectedMonth;
  late int selectedYear;

  /// 🔹 Localized months
  List<String> get _months => [
        "month_january".tr,
        "month_february".tr,
        "month_march".tr,
        "month_april".tr,
        "month_may".tr,
        "month_june".tr,
        "month_july".tr,
        "month_august".tr,
        "month_september".tr,
        "month_october".tr,
        "month_november".tr,
        "month_december".tr,
      ];
  final List<int> _years = List.generate(
    DateTime.now().year - 1950 + 1,
    (index) => 1950 + index,
  );

  @override
  void initState() {
    super.initState();

    // Initialize the selected values to the current date
    final now = DateTime.now();
    selectedDay = now.day;
    selectedMonth = _months[now.month - 1];
    selectedYear = now.year;
  }

  List<int> get _days {
    int monthIndex = _months.indexOf(selectedMonth) + 1;
    return List.generate(
      _daysInMonth(selectedYear, monthIndex),
      (index) => index + 1,
    );
  }

  int _daysInMonth(int year, int month) {
    if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      return 31;
    }
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  void _notifyDateSelected() {
    widget.onDateSelected(_formatSelectedDate());
  }

  String _formatSelectedDate() {
    final monthIndex = _months.indexOf(selectedMonth) + 1;
    final formattedDay = selectedDay.toString().padLeft(
          2,
          '0',
        ); // no leading zero
    final formattedMonth = monthIndex.toString().padLeft(
          2,
          '0',
        ); // no leading zero

    return '$selectedYear-$formattedMonth-$formattedDay';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildYearPicker(),
            _buildMonthPicker(),
            _buildDayPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildYearPicker() {
    final bool isArabic = LocalStorage_language().read() == "ar" ? true : false;

    return PickerWidget<int>(
      items: _years,
      selectedItem: selectedYear,
      initialIndex: _years.indexOf(selectedYear),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedYear = value;
          _adjustSelectedDay();
        });
      },
      displayBuilder: (item, isSelected) => PickerContainer(
        text: item.toString(),
        isSelected: isSelected,
        borderRadius: BorderRadius.only(
          topRight: isArabic ? const Radius.circular(12) : Radius.zero,
          bottomRight: isArabic ? const Radius.circular(12) : Radius.zero,
          topLeft: !isArabic ? const Radius.circular(12) : Radius.zero,
          bottomLeft: !isArabic ? const Radius.circular(12) : Radius.zero,
        ),
        border: Border(
          top: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
          right: isArabic
              ? BorderSide(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 1.5,
                )
              : BorderSide.none,
          left: !isArabic
              ? BorderSide(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 1.5,
                )
              : BorderSide.none,
          bottom: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return PickerWidget<String>(
      items: _months,
      selectedItem: selectedMonth,
      initialIndex: _months.indexOf(selectedMonth),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedMonth = value;
          _adjustSelectedDay();
        });
      },
      displayBuilder: (item, isSelected) => PickerContainer(
        text: item,
        isSelected: isSelected,
        borderRadius: BorderRadius.zero,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDayPicker() {
    final bool isArabic = LocalStorage_language().read() == "ar" ? true : false;

    return PickerWidget<int>(
      items: _days,
      selectedItem: selectedDay,
      initialIndex: _days.indexOf(selectedDay),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedDay = value;
          _notifyDateSelected();
        });
      },
      displayBuilder: (item, isSelected) => PickerContainer(
        text: item.toString(),
        isSelected: isSelected,
        borderRadius: BorderRadius.only(
          topLeft: isArabic ? const Radius.circular(12) : Radius.zero,
          bottomLeft: isArabic ? const Radius.circular(12) : Radius.zero,
          topRight: !isArabic ? const Radius.circular(12) : Radius.zero,
          bottomRight: !isArabic ? const Radius.circular(12) : Radius.zero,
        ),
        border: Border(
          top: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
          left: isArabic
              ? BorderSide(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 1.5,
                )
              : BorderSide.none,
          right: !isArabic
              ? BorderSide(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 1.5,
                )
              : BorderSide.none,
          bottom: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _adjustSelectedDay() {
    // Adjust the selected day if it exceeds the number of days in the new month/year
    if (selectedDay >
        _daysInMonth(selectedYear, _months.indexOf(selectedMonth) + 1)) {
      selectedDay = _daysInMonth(
        selectedYear,
        _months.indexOf(selectedMonth) + 1,
      );
    }
    _notifyDateSelected();
  }
}

class PickerWidget<T> extends StatelessWidget {
  final List<T> items;
  final T selectedItem;
  final int initialIndex;
  final ValueChanged<T> onSelectedItemChanged;
  final Widget Function(T, bool) displayBuilder;

  const PickerWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.initialIndex,
    required this.onSelectedItemChanged,
    required this.displayBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: 35,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          onSelectedItemChanged(items[index]);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final item = items[index];
            final isSelected = selectedItem == item;

            return displayBuilder(item, isSelected);
          },
          childCount: items.length,
        ),
      ),
    );
  }
}

class PickerContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final BorderRadius borderRadius;
  final Border border;

  const PickerContainer({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.borderRadius,
    required this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: isSelected ? border : null,
        borderRadius: borderRadius,
        color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSelected ? 18 : 15,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.green
              : Colors.black.withOpacity(
                  0.6,
                ), // Faint color for non-selected text
        ),
      ),
    );
  }
}
