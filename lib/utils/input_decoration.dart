import 'package:flutter/material.dart';

class FormHelper {
  static InputDecoration inputDecoration({
    required BuildContext context,
    InputBorder? enabledBorder,
    InputBorder? border,
    Color? fillColor,
    bool? filled,
    Widget? prefixIcon,
    String? hintText,
    String? labelText,
    TextStyle? labelStyle,
  }) =>
      InputDecoration(
        enabledBorder: enabledBorder ??
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5)),
        border: border ?? OutlineInputBorder(borderSide: BorderSide()),
        fillColor: fillColor ?? Colors.white,
        filled: filled ?? true,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle ??
            Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
      );
}
