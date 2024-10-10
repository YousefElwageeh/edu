import 'package:edu/src/config/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? labelStyle;
  TextInputType? keyboardType;
  void Function()? suffixIconOnPressed;
  bool obscureText = false;
  String? Function(String?)? validator;
  TextEditingController? textEditingController;
  void Function(String)? onChanged;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onFieldSubmitted;
  FocusNode? focusNode;
  bool? enabled;
  CustomTextFormField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.labelStyle,
    this.keyboardType,
    this.suffixIconOnPressed,
    required this.obscureText,
    this.validator,
    this.textEditingController,
    this.onChanged,
    this.enabledBorder,
    this.focusedBorder,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
      controller: textEditingController,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        label: Text(
          label,
          style: font24GreyBold,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        hintText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        //   labelStyle: labelStyle,
        //   enabledBorder: enabledBorder,
        //   focusedBorder: focusedBorder

        // errorText: _loginViewModel.isUserNameVaild.value
        //     ? null
        //     : AppStrings.usernameError.tr
      ),
    );
  }
}
