import 'package:edu/src/config/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  String text;
  Color? color;
  Color? textColor;
  Color? borderColor;
  CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: color ?? ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: borderColor != null
                      ? Border.all(color: borderColor!)
                      : null),
              child: Text(
                text,
                style: font16WhiteBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
