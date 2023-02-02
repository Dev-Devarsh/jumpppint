import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/colors.dart';

import '../../utills/enum/font_type.dart';

class CommonButton extends StatefulWidget {
  const CommonButton(
      {Key? key,
      this.width,
      this.height,
      this.backgroundColor,
      required this.textColor,
      required this.buttonText,
      required this.isBorder,
      this.borderColor,
      required this.onTap,
      this.padding,
      this.isItalic = false})
      : super(key: key);

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color textColor;
  final String buttonText;
  final bool isBorder;
  final Color? borderColor;
  final void Function() onTap;
  final EdgeInsets? padding;
  final bool isItalic;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? InkWell(
            onTap: widget.onTap,
            child: Container(
              width: widget.width,
              height: widget.height ?? 36,
              decoration: BoxDecoration(
                color: widget.isBorder
                    ? Colors.transparent
                    : widget.backgroundColor ?? AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5),
                border: widget.isBorder
                    ? Border.all(
                        color: widget.borderColor ?? AppColors.borderColor,
                        width: 1.0,
                      )
                    : const Border.fromBorderSide(BorderSide.none),
              ),
              padding: widget.padding ??
                  const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.buttonText,
                    textAlign: TextAlign.center,
                    style: AppThemeState().customTextStyle(
                        fontSize: 14,
                        fontStyle: widget.isItalic
                            ? FontStyle.italic
                            : FontStyle.normal,
                        color: widget.textColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ],
              ),
            ),
          )
        : Material(
            color: widget.isBorder
                ? Colors.transparent
                : widget.backgroundColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                width: widget.width,
                height: widget.height ?? 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: widget.isBorder
                      ? Border.all(
                          color: widget.borderColor ?? AppColors.borderColor,
                          width: 1.0,
                        )
                      : const Border.fromBorderSide(BorderSide.none),
                ),
                padding: widget.padding ??
                    const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.buttonText,
                      textAlign: TextAlign.center,
                      style: AppThemeState().customTextStyle(
                          fontSize: 14,
                          fontStyle: widget.isItalic
                              ? FontStyle.italic
                              : FontStyle.normal,
                          color: widget.textColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
