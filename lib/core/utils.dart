import 'package:flutter/material.dart';

const kMonths = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

bool intToBool(int value) {
  return value == 0 ? false : true;
}

bool isToday(DateTime date) {
  final now = DateTime.now().toString().split(' ').first;
  final tmp = date.toString().split(' ').first;

  return now == tmp;
}

String formatDateTime(DateTime date, BuildContext context) {
  final time = TimeOfDay(hour: date.hour, minute: date.minute).format(context);
  return '${kMonths[date.month]} ${date.day} $time';
}

String formatDate(DateTime date) {
  return '${kMonths[date.month]} ${date.day}';
}
