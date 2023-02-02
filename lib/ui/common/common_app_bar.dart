import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';

class CommonAppBar extends StatefulWidget {
  /// Appbar title
  final String? title;

  /// Widgets to display after the title.
  final Widget? leading;

  /// List of Widgets to display after the title.
  /// It's the same with the action property in the default appbar widget
  final List<Widget>? actions;

  final bool centerTitle;

  final bool isBackButtonVisible;

  final bool isTitleVisible;

  final bool isLogoVisible;

  final double? leadingWidth;

  final double? elevation;

  const CommonAppBar(
      {this.title,
      this.leading,
      this.actions,
      this.centerTitle = true,
      this.isBackButtonVisible = true,
      this.isTitleVisible = true,
      this.isLogoVisible = false,
      this.leadingWidth,
      this.elevation});

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return AppBar(
      title: widget.isTitleVisible
          ? _getTitle(_appTheme)
          : widget.isLogoVisible
              ? _getAppIcon()
              : const Offstage(),
      automaticallyImplyLeading: false,
      centerTitle: widget.centerTitle,
      leading:
          widget.isBackButtonVisible ? _getBackImageOnAppbar() : widget.leading,
      leadingWidth: widget.isBackButtonVisible ? 48 : widget.leadingWidth,
      actions: widget.actions,
      elevation: widget.elevation,
      backgroundColor: AppColors.appBarColor,
      systemOverlayStyle: !kIsWeb && Platform.isIOS
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.light,
    );
  }

  Widget _getTitle(AppThemeState _appTheme) {
    return Text(
      widget.title!,
      style: _appTheme.customTextStyle(
          fontSize: 20,
          color: AppColors.whiteColor,
          fontWeightType: FWT.regular,
          fontFamilyType: FFT.nunito),
    );
  }

  Widget _getBackImageOnAppbar() {
    return InkWell(
      child: SvgPicture.asset(
        SVGPath.backIcon,
      ).paddingAll(17),
      onTap: () {
        Get.back();
      },
    );
  }

  Widget _getAppIcon() {
    return Image.asset(
      PNGPath.logo,
      height: 90,
      width: 228,
    );
  }
}
