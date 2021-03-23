import 'package:intl/intl.dart';

class DateTimeHelper {
  static String calculateDurationValidate(DateTime validateDate) {
    var timeSpan = DateTime.now().difference(validateDate);
    final num totalMin = timeSpan.inMinutes;

    // 1 day = 1440 min
    int days = totalMin ~/ 1440;
    double remainingMinInDay = ((totalMin / 1440) - days) * 1440;
    int hours = remainingMinInDay ~/ 60;
    double remainingMinInHour = (remainingMinInDay / 60) - hours;
    int min = (remainingMinInHour * 60).round();

    return '$days Days ${hours}h ${min}m';
  }

  static String formatDateTime({DateTime dateTime, String format}) {
    return DateFormat(format).format(dateTime);
  }
}
