import 'package:flutter/material.dart';
import '../../definitions/sizes.dart';
import '../../definitions/text.dart';

class Button extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback? onClick;
  final bool loading;
  final bool outlined;
  final IconData? icon;
  final AppSize size;

  Button({
    Key? key,
    required this.label,
    this.onClick,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.loading = false,
    this.icon,
    this.outlined = false,
    this.size = AppSize.medium,
  }) : super(key: key);

  Color get txtColor => outlined ? color : textColor;
  Color get bgColor => outlined ? textColor : color;
  double get textSize => AppSizes.text(size);
  double get spacing => AppSizes.spacing(size);

  final radius = BorderRadius.circular(4);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onClick,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: spacing * 2, vertical: spacing),
          decoration: BoxDecoration(
            borderRadius: radius,
            color: bgColor,
            border: Border.all(color: color),
          ),
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: spacing),
                  child: Icon(
                    icon,
                    color: txtColor,
                    size: textSize,
                  ),
                ),
              if (loading)
                Container(
                  width: textSize,
                  height: textSize,
                  margin: EdgeInsets.only(right: spacing),
                  child: CircularProgressIndicator(
                    color: txtColor,
                    strokeWidth: 2.5,
                  ),
                ),
              AppText.build(
                label,
                color: txtColor,
                size: textSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
