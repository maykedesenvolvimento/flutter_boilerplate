import 'package:flutter/material.dart';
import '../../definitions/sizes.dart';
import '../interfaces/form.dart';
import '../models/form_item.dart';
import 'input.dart';
import 'button.dart';

class AppForm extends StatefulWidget {
  final FormInterface data;
  final Function(Map<String, dynamic> onSave) onSave;

  const AppForm({
    Key? key,
    required this.data,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AppForm> createState() => _FormState();
}

class _FormState extends State<AppForm> {
  final nodes = [];

  late List<FormItem> items = widget.data.toForm();
  late List<TextEditingController> controllers = items.map((item) {
    nodes.add(FocusNode());
    return TextEditingController(text: item.toString());
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map((e) {
          final idx = items.indexOf(e);

          return Padding(
            padding: EdgeInsets.only(
              bottom: AppSizes.spacing(AppSize.small) * 2,
            ),
            child: Input(
              size: AppSize.medium,
              controller: controllers[idx],
              node: nodes[idx],
              onChange: (val) {
                setState(() {
                  e.value = val;
                });
              },
              item: e,
            ),
          );
        }).toList(),
        Button(
          label: 'Salvar',
          onClick: () {
            final Map<String, dynamic> map = {};
            items.map((e) {
              map[e.key] = e.value;
            }).toList();
            widget.onSave(map);
          },
        ),
      ],
    );
  }
}
