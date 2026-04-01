import 'package:intl/intl.dart';

class Dates {
  String getDateTimeWithSpecificFormat(int createAt) {
    // Convert the timestamp to a DateTime object
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createAt);

    // Format the DateTime object to a string
    // return DateFormat('yyyy-MM-dd – kk:mm').format(date);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formatDate(int timestamp) {
    // Convert the timestamp to milliseconds
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Define the format you want
    DateFormat formatter = DateFormat('MMMM d, yyyy');

    // Format the date and return the string
    return formatter.format(date);
  }

  DateTime convertStringToTime(String value, {required String locale}) {
    // Set the locale for DateFormat based on the input locale
    Intl.defaultLocale = locale;

    // Initialize the DateFormat with the appropriate pattern
    DateFormat dateFormat = DateFormat("dd-MM-yyyy hh:mm a", locale);

    try {
      return dateFormat.parse(value);
    } catch (e) {
      rethrow;
    }
  }

  String getDateFromTimeStamp(int timestamp) {
    // Example timestamp (milliseconds since epoch)

    // Convert timestamp to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the DateTime object
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Output the formatted date
    return formattedDate;
  }

  String getRelativeTime(int timestamp, {String locale = 'en'}) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(date);

    if (locale == 'ar') {
      if (difference.inDays > 0) {
        return 'منذ  ${difference.inDays} يوم';
      } else if (difference.inHours > 0) {
        return 'منذ  ${difference.inHours} ساعة';
      } else if (difference.inMinutes > 0) {
        return 'منذ  ${difference.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } else {
      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'just now';
      }
    }
  }

  bool isDateTimeLessThanCurrent(
    String timeString,
    String dateString,
  ) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateFormat timeFormat = DateFormat("hh:mm a");

    // Parse the date and time strings
    DateTime parsedDate = dateFormat.parse(dateString);
    DateTime parsedTime = timeFormat.parse(timeString);

    // Combine the parsed date and time into a single DateTime object
    DateTime inputDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    // Get the current date and time
    DateTime now = DateTime.now();

    // Compare the inputDateTime with now
    return inputDateTime.isBefore(now);
  }

  String getTimeFromTimeStamp(String timestamp) {
    String timeFrom = timestamp;
    int timestampMillis = int.parse(timeFrom); // Replace with your timestamp

    // Convert timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMillis);

    int hr = dateTime.hour;
    int minutes = dateTime.minute;
    String hrs = hr >= 10 ? "$hr" : "0$hr";
    String mnts = minutes >= 10 ? "$minutes" : "0$minutes";

    // Format DateTime as time string (HH:mm)
    String formattedTime = "$hrs:$mnts";
    return formattedTime;
  }

  String getWeekdayName(String dateString) {
    final formatter = DateFormat('dd-MM-yyyy');
    final date = formatter.parse(dateString);
    final weekdayName = DateFormat('EEEE', 'ar').format(date);
    return weekdayName;
  }

  String daysAgo(int timeStamp, String locale) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    // Format the output based on locale
    if (locale == 'en') {
      return difference == 1 ? '$difference day ago' : '$difference days ago';
    } else if (locale == 'ar') {
      // Localized string for Arabic
      final arabicDays =
          difference == 1 ? 'منذ $difference يوم' : 'منذ $difference أيام';
      return arabicDays;
    } else {
      return '$difference days ago'; // Default to English if the locale is not recognized
    }
  }

  String timestampToEgyptTime(int timestamp) {
    // Convert timestamp to milliseconds
    DateTime dateTimeUtc =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Egypt time zone offset (UTC+2)
    Duration egyptOffset = const Duration(hours: 2);

    // Convert to Egypt time
    DateTime dateTimeEgypt = dateTimeUtc.add(egyptOffset);

    return formatEgyptTime(dateTimeEgypt);
  }

  String formatEgyptTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('HH:mm yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  String localizeDateTime(String date, String time, String locale) {
    // Combine date and time strings
    String dateTimeString = "$date $time";

    // Parse the combined date and time string
    DateTime dateTime = DateFormat("dd-MM-yyyy hh:mm a").parse(dateTimeString);

    // Set the locale
    Intl.defaultLocale = locale;

    // Create a localized DateFormat
    DateFormat dateFormat = DateFormat.yMMMMEEEEd(locale).add_jm();

    // Format the date and time
    String localizedDateTime = dateFormat.format(dateTime);

    return localizedDateTime;
  }

  // to get value of to time in ui  use in the card of home list
  String addMinutesToTime(String currentTime) {
    // Current time string
    String timeString = currentTime;

    // Parse the time string
    DateFormat inputFormat = DateFormat("h:mm a");
    DateTime parsedTime = inputFormat.parse(timeString);

    // Add minutes
    int minutesToAdd = 67; // Adding 67 minutes
    DateTime updatedTime = parsedTime.add(Duration(minutes: minutesToAdd));

    // Format the updated time back to a string
    String updatedTimeString = DateFormat("h:mm a").format(updatedTime);
    return updatedTimeString;
  }

  String todayDate() {
    DateTime now = DateTime.now();
    // Format the date as a string
    String formattedMonth = now.month < 10 ? '0${now.month}' : '${now.month}';
    String formattedDay = now.day < 10 ? '0${now.day}' : '${now.day}';
    String formattedDate = '$formattedDay-$formattedMonth-${now.year}';
    return formattedDate;
  }

  // Function to parse date in dd-MM-yyyy format
  DateTime parseDate(String dateString) {
    try {
      List<String> parts = dateString.split('-');
      if (parts.length != 3) throw const FormatException('Invalid date format');

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      // Handle the error as needed, e.g., return a default date or rethrow the exception
      rethrow; // Rethrow the exception to propagate it further if necessary
    }
  }

  String getCurrentDay() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  String getdDateMinusDay(int day) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: day));

    // Format the date as a string
    String formattedMonth =
        yesterday.month < 10 ? '0${yesterday.month}' : '${yesterday.month}';
    String formattedDay =
        yesterday.day < 10 ? '0${yesterday.day}' : '${yesterday.day}';
    String formattedDate = '${yesterday.year}-$formattedMonth-$formattedDay';
    return formattedDate;
  }

  String getCurrentMonthName({bool? inarabic}) {
    DateTime now = DateTime.now();

    // Format the month name using intl package
    String format = inarabic == true ? 'ar' : 'en_US';
    DateFormat monthFormat = DateFormat('MMMM', format);
    return monthFormat.format(now);
  }

  String getMonthAndDayTitle() {
    int currentDay = DateTime.now().day;
    String monthName = Dates().getCurrentMonthName();
    return "$monthName,$currentDay";
  }

  double getNumOfDayRelatedtoGoals() {
    //  DateTime currentDate = DateTime();
    DateTime startDate = DateTime(2024, 2, 18);
    Duration ninetyDays = const Duration(days: 7);
    // Add 90 days to the current date
    DateTime newDate = startDate.add(ninetyDays);

    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    int daysAgo = 7 - (currentDate.difference(newDate).inDays.abs());
    return daysAgo.toDouble();
  }
}
