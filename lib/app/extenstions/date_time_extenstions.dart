import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatToWord() {
    return DateFormat.yMMMMEEEEd().format(this);
  }

  String format([String pattern = 'dd/MM/yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }

  String formatDivider([String pattern = 'dd-MM-yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay =>
      DateTime(year, month, day, 23, 59, 59, 999);
}



/// USAGE
// DateTime.now().format();
//
// DateTime.now().format('MM/yyyy');
//
// DateTime.now().format('MM/yyyy', 'es');
