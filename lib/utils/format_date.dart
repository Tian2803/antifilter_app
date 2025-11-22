import 'package:easy_localization/easy_localization.dart';

class FormatDate {
  static String getMonthName(int month) {
    const months = [
      'january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december'
    ];
    return 'history.months.${months[month - 1]}'.tr();
  }

  static String formatDateDetail(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(DateTime(dateTime.year, dateTime.month, dateTime.day));
    final time = '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (difference.inDays == 0) {
      return 'history.todayAt'.tr(namedArgs: {'time': time});
    } else if (difference.inDays == 1) {
      return 'history.yesterdayAt'.tr(namedArgs: {'time': time});
    } else {
      final monthName = getMonthName(dateTime.month);
      return 'history.dateFormat'.tr(namedArgs: {
        'day': dateTime.day.toString(),
        'month': monthName,
        'year': dateTime.year.toString(),
      });
    }
  }

  static String formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(DateTime(dateTime.year, dateTime.month, dateTime.day));

    if (difference.inDays == 0) {
      return 'history.today'.tr();
    } else if (difference.inDays == 1) {
      return 'history.yesterday'.tr();
    } else if (difference.inDays >= 365) {
      final years = dateTime.year == now.year ? 0 : now.year - dateTime.year;
      return years == 1 ? 'history.yearAgo'.tr() : 'history.yearsAgo'.tr(args: [years.toString()]);
    } else {
      return 'history.daysAgo'.tr(args: [difference.inDays.toString()]);
    }
  }
}
