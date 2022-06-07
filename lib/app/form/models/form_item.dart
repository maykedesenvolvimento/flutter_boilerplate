import 'package:flutter/material.dart';
import '../../extensions/date_time.dart';
import '../enums/input_type.dart';

class FormItem {
  String key;
  String label;
  dynamic value;
  List<dynamic> items;
  InputType type;

  FormItem({
    required this.key,
    required this.label,
    required this.value,
    required this.type,
    this.items = const [],
  });

  @override
  String toString() {
    if (value == null || selectBoxTypes.contains(type)) return '';
    switch (type) {
      case InputType.date:
        return (value as DateTime).showDate();
      case InputType.time:
        return (value as TimeOfDay).showTime();
      default:
        return value.toString();
    }
  }
}
