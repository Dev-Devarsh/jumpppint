import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jumppoint_app/utills/app_theme.dart';

import '../../utills/colors.dart';
import '../../utills/enum/font_type.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
      required this.editController,
      required this.focusNode,
      required this.labelText,
      this.labelColor,
      required this.onChange,
      required this.onValidate,
      this.maxLength,
      this.backgroundColor,
      this.isEnabled = true,
      this.textAlign = TextAlign.start,
      this.textInputType,
      this.maxLines = 1,
      this.minLines,
      this.prefixIcon,
      this.prefixWidget,
      this.contentPadding,
      this.isAlignLabelWithHint,
      this.isPassword,
      this.textInputAction,
      this.isDenySpaces})
      : super(key: key);

  final TextEditingController editController;
  final FocusNode focusNode;
  final int? maxLength;
  final String labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  bool isEnabled = true;
  TextAlign textAlign;
  bool? isPassword;
  TextInputType? textInputType;
  final void Function(String?) onChange;
  final String? Function(String?) onValidate;
  int maxLines = 1;
  int? minLines = 1;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final EdgeInsets? contentPadding;
  final bool? isAlignLabelWithHint;
  bool? isDenySpaces;
  TextInputAction? textInputAction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        controller: widget.editController,
        focusNode: widget.focusNode,
        enabled: widget.isEnabled,
        textAlign: widget.textAlign,
        obscuringCharacter: '*',
        keyboardType: widget.textInputType ?? TextInputType.text,
        inputFormatters:
            widget.textInputType != null ? onGetInputFormatter() : const [],
        onChanged: widget.onChange,
        obscureText: widget.isPassword ?? false,
        maxLines: widget.maxLines,
        minLines: widget.minLines ?? 1,
        maxLength: widget.maxLength ?? 100,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding ??
              const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
          errorMaxLines: 3,
          alignLabelWithHint: widget.isAlignLabelWithHint ?? false,
          prefixIcon: widget.prefixWidget,
          prefix: widget.prefixIcon ?? const Offstage(),
          counterText: "",
          errorStyle: AppThemeState().customTextStyle(
              fontSize: 12,
              fontFamilyType: FFT.nunito,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular),
          labelText: widget.labelText,
          labelStyle: AppThemeState().customTextStyle(
              fontSize: 14,
              fontFamilyType: FFT.nunito,
              color: widget.labelColor ?? AppColors.textSecondaryColor,
              fontWeightType: FWT.regular),
          filled: true,
          fillColor: widget.backgroundColor ?? AppColors.backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColors.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
        ),
        style: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular),
        validator: (value) => widget.onValidate(value));
  }

  List<TextInputFormatter> onGetInputFormatter() {
    if (widget.textInputType == TextInputType.phone ||
        widget.textInputType == TextInputType.number ||
        widget.textInputType == TextInputType.numberWithOptions(signed: true)) {
      return [FilteringTextInputFormatter.allow(RegExp("(^[+0-9]+\$)"))];
    } else if (widget.textInputType == TextInputType.none) {
      return [
        FilteringTextInputFormatter.allow(RegExp("(^[+A-Z+a-z+0-9]+\$)"))
      ];
    } else {
      return widget.isDenySpaces ?? false
          ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
          : const [];
    }
  }
}
