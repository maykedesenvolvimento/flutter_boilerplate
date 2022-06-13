import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/form/views/select_box.dart';
import 'package:flutter_boilerplate/app/form/views/select_item.dart';
import '../../definitions/text.dart';
import '../enums/input_type.dart';
import '../models/form_item.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final double? width;
  final Function(dynamic val) onChange;
  final List<dynamic> items;
  final FormItem item;

  const Input({
    Key? key,
    required this.item,
    required this.controller,
    required this.node,
    required this.onChange,
    this.width,
    this.items = const [],
  }) : super(key: key);

  double get spacing => 10;
  double get textSize => 14;

  TextInputType get inputType {
    switch (item.type) {
      case InputType.text:
        return TextInputType.text;
      case InputType.textArea:
        return TextInputType.multiline;
      default:
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
        floatingLabelBehavior: isSelectBox
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      );

  bool get readOnly => readOnlyTypes.contains(item.type);
  bool get isSelectBox => selectBoxTypes.contains(item.type);

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
        if (selected != null) {
          onChange(selected);
          controller.text = item.toString();
        }
      } else if (item.type == InputType.time) {
        final selected = await showTimePicker(
          context: context,
          initialTime: item.value ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
        );
        if (selected != null) {
          onChange(selected);
          controller.text = item.toString();
        }
      } else if (isSelectBox) {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return SelectBox(
              items: item.items,
              multiSelection: item.type == InputType.multiSelection,
              selectedItems: item.value == null
                  ? []
                  : item.value is List
                      ? item.value
                      : [item.value],
              onChange: (value) {
                onChange(value);
              },
            );
          },
        );
      }
    }

    return SizedBox(
      width: width,
      height: (item.type == InputType.textArea ? 15 : 6) * spacing,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            cursorHeight: textSize,
            decoration: decoration,
            controller: controller,
            focusNode: node,
            onChanged: onChange,
            readOnly: readOnly,
            style: AppText.style(),
            onTap: onTap,
            keyboardType: item.type == InputType.textArea
                ? TextInputType.multiline
                : TextInputType.text,
            maxLines: item.type == InputType.textArea ? 5 : 1,
          ),
          if (isSelectBox && item.value != null)
            item.value is List
                ? Row(
                    children: (item.value as List)
                        .map(
                          (e) => SelectItem(
                            height: spacing * 4,
                            label: e.toString(),
                            onClose: () {
                              onChange((item.value as List)
                                  .where(
                                      (item) => e.toString() != item.toString())
                                  .toList());
                            },
                          ),
                        )
                        .toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: AppText.build(item.value.toString()),
                  )
        ],
      ),
    );
  }
}
