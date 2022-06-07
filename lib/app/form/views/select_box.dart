import 'package:flutter/material.dart';
import '../../definitions/text.dart';
import '../../form/views/button.dart';

class SelectBox extends StatefulWidget {
  final List<dynamic> selectedItems;
  final List<dynamic> items;
  final bool multiSelection;
  final Function(dynamic value) onChange;

  const SelectBox({
    Key? key,
    required this.selectedItems,
    required this.items,
    required this.multiSelection,
    required this.onChange,
  }) : super(key: key);

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  List<String> get seletedItemsAsString =>
      selectedItems.map((e) => e.toString()).toList();

  late List<dynamic> selectedItems = widget.selectedItems;

  final double checkBoxSize = 48;

  final controller = TextEditingController();

  EdgeInsets get padding => const EdgeInsets.all(12);

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                label: AppText.build(
                  'Search',
                  color: Colors.black.withOpacity(0.6),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          ...widget.items
              .where((e) => e
                  .toString()
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()))
              .map((e) {
            return InkWell(
              onTap: () {
                if (widget.multiSelection) {
                  if (seletedItemsAsString.contains(e.toString())) {
                    selectedItems = selectedItems
                        .where((item) => item.toString() != e.toString())
                        .toList();
                  } else {
                    selectedItems.add(e);
                  }
                  setState(() {});
                } else {
                  widget.onChange(e);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  SizedBox(
                    height: checkBoxSize,
                    width: checkBoxSize,
                    child: seletedItemsAsString.contains(e.toString())
                        ? const Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : Container(),
                  ),
                  AppText.build(
                    e.toString(),
                    color: Colors.black.withOpacity(0.75),
                  ),
                ],
              ),
            );
          }).toList(),
          if (widget.multiSelection)
            Padding(
              padding: padding,
              child: Button(
                icon: Icons.done,
                circular: true,
                width: checkBoxSize,
                onClick: () {
                  widget.onChange(selectedItems);
                  Navigator.pop(context);
                },
              ),
            ),
        ],
      ),
    );
  }
}
