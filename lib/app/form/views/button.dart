import 'package:flutter/material.dart';
import '../../definitions/text.dart';

class Button extends StatelessWidget {
  final String? label;
  final Color color;
  final Color textColor;
  final VoidCallback? onClick;
  final bool loading;
  final bool outlined;
  final bool circular;
  final IconData? icon;
  final double? width;

  const Button({
    Key? key,
    this.label,
    this.onClick,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.circular = false,
    this.loading = false,
    this.icon,
    this.outlined = false,
    this.width,
  }) : super(key: key);

  Color get txtColor => outlined ? color : textColor;
  Color get bgColor => outlined ? textColor : color;
  double get textSize => 12;
  double get spacing => 10;

  BorderRadius get radius => BorderRadius.circular(circular ? width! / 2 : 4);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onClick,
        child: Container(
          width: width,
          height: circular ? width : null,
          padding: label == null
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(
                  horizontal: spacing * 2, vertical: spacing),
          decoration: BoxDecoration(
            borderRadius: radius,
            color: bgColor,
            border: Border.all(color: color),
          ),
          child: label == null
              ? Icon(
                  icon,
                  color: txtColor,
                )
              : Row(
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
