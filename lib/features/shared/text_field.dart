import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final bool isError;
  final IconData? icon;
  final bool? isIconLeft;
  final bool? isSafeText;
  final String? hintText;
  final String labelText;
  final String? helperText;
  final VoidCallback? onIconPress;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback onTap;
  final Function(String) onChanged;
  final VoidCallback onOutSideTap;

  const AppTextField(
      {Key? key,
      required this.labelText,
      this.controller,
      this.validator,
      this.hintText,
      this.helperText,
      this.keyboardType = TextInputType.text,
      this.isError = false,
      this.isIconLeft = false,
      this.isSafeText = false,
      this.icon,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.inputFormatters,
      this.onIconPress,
      required this.onTap,
      required this.onChanged,
      required this.onOutSideTap})
      : super(key: key);

  OutlineInputBorder getInputBorderConfig(BuildContext context) {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: isError ? Colors.red : Colors.grey, width: 3));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (isIconLeft != null && isIconLeft == false) {
      return TextFormField(
        obscureText: isSafeText != null && isSafeText == true ? true : false,
        enableSuggestions:
            isSafeText != null && isSafeText == true ? false : true,
        autocorrect: isSafeText != null && isSafeText == true ? false : true,
        style: const TextStyle(fontSize: 16),
        cursorColor: isError ? Colors.red : Colors.grey,
        validator: validator,
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        onTapOutside: (event) {
          onOutSideTap();
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: getInputBorderConfig(context),
            enabledBorder: getInputBorderConfig(context),
            focusedBorder: getInputBorderConfig(context),
            errorMaxLines: 3,
            labelStyle: isError
                ? const TextStyle(fontSize: 16, color: Colors.red)
                : const TextStyle(fontSize: 16, color: Colors.black),
            suffixIcon: onIconPress != null && icon != null
                ? IconButton(
                    onPressed: onIconPress,
                    icon: Icon(
                      icon,
                      color: isError ? Colors.red : Colors.grey,
                    ))
                : null,
            helperText: helperText,
            helperMaxLines: 2,
            helperStyle: isError
                ? const TextStyle(fontSize: 16, color: Colors.red)
                : const TextStyle(fontSize: 16, color: Colors.grey)),
        controller: controller,
      );
    }
    return TextFormField(
      style: const TextStyle(fontSize: 16, color: Colors.grey),
      cursorColor: isError ? Colors.red : Colors.grey,
      obscureText: isSafeText != null && isSafeText == true ? true : false,
      enableSuggestions:
          isSafeText != null && isSafeText == true ? false : true,
      autocorrect: isSafeText != null && isSafeText == true ? false : true,
      validator: validator,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      onTapOutside: (event) {
        onOutSideTap();
        FocusScope.of(context).unfocus();
      },
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: getInputBorderConfig(context),
          enabledBorder: getInputBorderConfig(context),
          focusedBorder: getInputBorderConfig(context),
          errorMaxLines: 3,
          labelStyle: isError
              ? themeData.textTheme.bodyMedium!.copyWith(color: Colors.red)
              : themeData.textTheme.bodyMedium,
          prefixIcon: onIconPress != null && icon != null
              ? IconButton(
                  onPressed: onIconPress,
                  icon: Icon(
                    icon,
                    color: isError ? Colors.red : Colors.grey,
                  ))
              : null,
          helperText: helperText,
          helperMaxLines: 2,
          helperStyle: isError
              ? themeData.textTheme.bodyMedium!.copyWith(color: Colors.red)
              : themeData.textTheme.bodyMedium),
      controller: controller,
    );
  }
}
