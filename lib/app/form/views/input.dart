import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../definitions/sizes.dart';
import '../../definitions/text.dart';
import '../enums/input_type.dart';
import '../models/form_item.dart';

class Input extends StatelessWidget {
  final AppSize size;
  final TextEditingController controller;
  final FocusNode node;
  final double? width;
  final Function(dynamic val)? onChange;
  final List<dynamic> items;
  final FormItem item;

  const Input({
    Key? key,
    required this.item,
    required this.size,
    required this.controller,
    required this.node,
    this.width,
    this.onChange,
    this.items = const [],
  }) : super(key: key);

  double get spacing => AppSizes.spacing(size);
  double get textSize => AppSizes.text(size);
  TextInputType get inputType {
    switch (item.type) {
      case InputType.date:
        return TextInputType.none;
      case InputType.time:
        return TextInputType.none;
      case InputType.text:
        return TextInputType.text;
      case InputType.textArea:
        return TextInputType.multiline;
      case InputType.selectBox:
        return TextInputType.none;
    }
  }

  InputDecoration get decoration => InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: item.type == InputType.textArea ? spacing * 2.5 : 0,
            horizontal: spacing * 2),
        label: AppText.build(
          item.label,
          size: textSize,
          color: Colors.black.withOpacity(0.6),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      );

  bool get readOnly => [
        InputType.date,
        InputType.time,
      ].contains(item.type);

  @override
  Widget build(BuildContext context) {
    onTap() async {
      if (item.type == InputType.date) {
        final selected = await showDatePicker(
          context: context,
          initialDate: item.value ?? DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (selected != null && onChange != null) {
          onChange!(selected);
          controller.text = item.toString();
        }
      }
      if (item.type == InputType.time) {
        final selected = await showTimePicker(
          context: context,
          initialTime: item.value ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
        );
        if (selected != null && onChange != null) {
          onChange!(selected);
          controller.text = item.toString();
        }
      }
    }

    return SizedBox(
      width: width,
      height: (item.type == InputType.textArea ? 15 : 6) * spacing,
      child: (item.type == InputType.selectBox)
          ? DropdownSearch(
              dropdownSearchDecoration: decoration,
              mode: Mode.MENU,
              items: item.items,
              focusNode: node,
              selectedItem: item.value,
              showSearchBox: item.type != InputType.selectBox,
              onChanged: onChange,
            )
          : TextField(
              cursorHeight: textSize,
              decoration: decoration,
              controller: controller,
              focusNode: node,
              onChanged: onChange,
              readOnly: readOnly,
              onTap: onTap,
              keyboardType: item.type == InputType.textArea
                  ? TextInputType.multiline
                  : TextInputType.text,
              maxLines: item.type == InputType.textArea ? 5 : 1,
            ),
    );
  }
}
