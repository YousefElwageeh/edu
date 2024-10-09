import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class DefultButton extends StatelessWidget {
  void Function()? onPressed;
  String text;
  Color? color;
  Color? textColor;
  Color? borderColor;
  DefultButton({
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
                  color: color ?? ColorsManager.primaryColorLight,
                  borderRadius: BorderRadius.circular(8),
                  border: borderColor != null
                      ? Border.all(color: borderColor!)
                      : null),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
