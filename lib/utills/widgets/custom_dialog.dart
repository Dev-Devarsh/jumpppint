import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../app_theme.dart';
import '../colors.dart';
import '../generated/locales.g.dart';

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  String? imagePath;
  double? height;
  double? width;
  final String message;
  String? title;
  final Function? onTap;
  String? positiveText;
  final String? negativeText;
  final Function? onNegativeTap;
  final TextAlign textAlign;
  final bool shouldClose;
  final bool isShowButton;
  final bool isRowButton;

  CustomDialog({
    this.imagePath = "",
    this.height = 100,
    this.width = 100,
    this.message = "",
    this.title,
    this.onTap,
    this.onNegativeTap,
    this.textAlign = TextAlign.left,
    this.positiveText,
    this.negativeText,
    this.shouldClose = true,
    this.isShowButton = true,
    this.isRowButton = false,
    Key? key,
  }) : super(key: key) {
    title ??= LocaleKeys.errorTitle.tr;
    positiveText ??= LocaleKeys.okayTitle.tr;
  }

  late AppThemeState _appTheme;

  @override
  Widget build(BuildContext context) {
    _appTheme = AppTheme.of(context);
    return Column(
      children: [
        Text(
          title!,
          style: _appTheme.textStyleMontBold(
              fontSize: 14, color: AppColors.textPrimaryColor),
        ),
        Text(
          message,
          style: _appTheme.textStyleMontMedium(
              fontSize: 12, color: AppColors.textPrimaryColor),
          textAlign: TextAlign.center,
        ),
        isRowButton ? getRowButton(context) : getColummButton(context),
      ],
    );
  }

  _closeDialog(BuildContext context) {
    Get.close(1);
  }

  getRowButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _closeDialog(context);
            onNegativeTap?.call();
          },
          child: Container(
            width: 290.w,
            height: 100.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(76.h))),
            child: Center(
              child: Text(
                negativeText!,
                style: _appTheme.textStyleMontSemiBold(
                    fontSize: 36, color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        InkWell(
          onTap: () {
            _closeDialog(context);
            onTap?.call();
          },
          child: Container(
            width: 290.w,
            height: 100.h,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(76.h))),
            child: Center(
              child: Text(
                positiveText!,
                style: _appTheme.textStyleMontSemiBold(
                    fontSize: 36, color: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getColummButton(BuildContext context) {
    return Column(
      children: [
        isShowButton
            ? InkWell(
              onTap: () {
                _closeDialog(context);
                onTap?.call();
              },
              child: Container(
                width: double.infinity,
                height: 100.h,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(76.h))),
                child: Center(
                  child: Text(
                    positiveText!,
                    style: _appTheme.textStyleMontSemiBold(
                        fontSize: 36, color: AppColors.whiteColor),
                  ),
                ),
              ),
            )
            : const Offstage(),
        negativeText != null
            ? Padding(
                padding: EdgeInsets.only(right: 85.h, left: 85.h, bottom: 40.h),
                child: InkWell(
                  onTap: () {
                    _closeDialog(context);
                    onNegativeTap?.call();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: Center(
                      child: Text(
                        negativeText!,
                        style: _appTheme.textStyleMontSemiBold(
                            fontSize: 36, color: AppColors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              )
            : const Offstage(),
      ],
    );
  }
}
