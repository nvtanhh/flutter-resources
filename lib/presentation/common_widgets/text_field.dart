import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'spacer.dart';
import 'text.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final TextStyle? style;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool autocorrect;
  final bool autofocus;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? enabled;
  final BorderRadius? borderRadius;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    this.labelText,
    this.style,
    this.focusNode,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.maxLines,
    this.decoration,
    this.autocorrect = false,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.maxLength,
    this.enabled,
    this.borderRadius,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorder = _getDefaultBorderRadius();
    final textField = TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      style: style,
      maxLines: maxLines,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      enabled: enabled,
      autocorrect: autocorrect,
      autofocus: autofocus,
      decoration: InputDecoration(
        isDense: decoration?.isDense ?? true,
        filled: decoration?.filled,
        fillColor: decoration?.fillColor,
        prefix: decoration?.prefix,
        prefixIcon: decoration?.prefixIcon,
        suffix: decoration?.suffix,
        suffixIcon: decoration?.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(14.0),
                child: decoration?.suffixIcon,
              )
            : null,
        suffixIconConstraints: decoration?.suffixIconConstraints ??
            const BoxConstraints(minHeight: 16.0, minWidth: 16.0),
        hintText: decoration?.hintText,
        contentPadding: decoration?.contentPadding ??
            const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
        border: decoration?.border ?? defaultBorder,
        focusedBorder: decoration?.focusedBorder ?? defaultBorder,
        enabledBorder: decoration?.enabledBorder ?? defaultBorder,
        disabledBorder: decoration?.disabledBorder ?? defaultBorder,
        errorBorder: decoration?.errorBorder ?? defaultBorder,
        errorText: decoration?.errorText,
        counterText: '',
      ),
      maxLength: maxLength,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null)
          Padding(
            padding: AppSpacer.edgeInsetsBottom8,
            child: ThemedText(
              labelText!,
              type: ThemedTextType.labelLarge,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        textField,
      ],
    );
  }

  InputBorder _getDefaultBorderRadius() {
    return OutlineInputBorder(
      borderRadius: borderRadius ?? AppSpacer.radius8,
    );
  }
}
