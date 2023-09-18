import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/utils/textstyle.dart';

class TextFeildData extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final int? maxlength;
  final bool? obscureText;
  final String hintText;
  final String label;
  final String? errorText;
  final int? maxLine;
  final Function(String)? onChanged;
  final bool? readOnly;
  final TextCapitalization? capitalText;
  final double? cursorHeight;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool labelShowl;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final Function()? onTap;
  final bool? enableInteractiveSelection;

  const TextFeildData({
    Key? key,
    required this.controller,
    this.obscureText,
    this.validator,
    this.readOnly,
    required this.label,
    this.prefixIcon,
    this.padding,
    this.cursorHeight,
    this.capitalText,
    this.onChanged,
    this.hintStyle,
    this.maxLine,
    required this.hintText,
    this.suffixIcon,
    this.textInputFormatter,
    this.keyboardType,
    this.focusNode,
    this.autovalidateMode,
    this.onTap,
    this.errorText,
    this.textInputAction,
    this.labelShowl = true,
    this.enableInteractiveSelection,
    this.labelStyle,
    this.maxlength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelShowl) Text(label, style: AppTextStyle.sub14Title),
        if (labelShowl) const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          maxLength: maxlength,
          enableInteractiveSelection: enableInteractiveSelection,
          cursorHeight: cursorHeight ?? 20,
          obscureText: obscureText ?? false,
          autovalidateMode: autovalidateMode,
          validator: validator,
          keyboardType: keyboardType,
          style: AppTextStyle.mainTitle,
          maxLines: maxLine ?? 1,
          focusNode: focusNode,
          onChanged: onChanged,
          autocorrect: false,
          readOnly: readOnly ?? false,
          textCapitalization: capitalText ?? TextCapitalization.none,
          cursorColor: Colors.black,
          // inputFormatters: textInputFormatter,
          onTap: onTap,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            filled: true,
          fillColor: Colors.grey[150],
            contentPadding:
                padding ?? const EdgeInsets.only(top: 7, right: 15, bottom: 7),
            errorText: errorText,
            prefixIconConstraints:
                prefixIcon != null ? null : const BoxConstraints(maxWidth: 15),
            prefixIcon: prefixIcon ?? Container(width: 15),
            suffixIcon: suffixIcon,
            errorMaxLines: 4,
            hintText: hintText,
            hintStyle: hintStyle ?? AppTextStyle.sub14Title,
            labelStyle: labelStyle,
            // errorStyle: AppTextStyle.red12w700,
            // fillColor: AppColors.backgroundColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black26),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ],
    );
  }
}
