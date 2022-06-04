import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String showDate() {
    return DateFormat('dd/MM/yyyy').format(toLocal());
  }
}

extension TimeExtensions on TimeOfDay {
  String showTime() {
    NumberFormat formatter = NumberFormat('00');
    return '${formatter.format(hour)}:${formatter.format(minute)}';
  }
}
