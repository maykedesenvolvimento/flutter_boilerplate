import 'package:flutter/material.dart';
import '../../definitions/text.dart';

class SelectItem extends StatelessWidget {
  final double height;
  final String label;
  final VoidCallback onClose;

  const SelectItem({
    Key? key,
    required this.height,
    required this.label,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12),
          height: height,
          alignment: Alignment.center,
          child: AppText.build(label),
        ),
        InkWell(
          onTap: onClose,
          child: SizedBox(
            height: height,
            width: height,
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
