import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:jumppoint_app/ui/browsecargo/presentation/controllers/browse_cargo_controller.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/generated/locales.g.dart';

class WayBillView extends GetResponsiveView<BrowseCargoController> {
  @override
  Widget? builder() {
    if (screen.isPhone) {
      return phone();
    } else if (screen.isTablet) {
      return tablet();
    } else if (screen.isDesktop) {
      return desktop();
    } else {
      return phone();
    }
  }

  @override
  Widget? phone() {
    return SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 300),
              childAnimationBuilder: (widget) => FadeInAnimation(
                child: widget,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: onGetJumpPointWayBill(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: onGetDownloadWayBill(),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return phone();
  }

  onGetJumpPointWayBill() {
    return Image.asset(
      fit: BoxFit.fill,
      PNGPath.dummyWayBills,
    );
  }

  onGetDownloadWayBill() {
    return Column(
      children: [
        onCommonTextFormField(
            LocaleKeys.wayBillDes.tr, 16, AppColors.textSecondaryColor),
        InkWell(
          onTap: (){
            controller.getItemLabel();
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: onCommonTextFormField(
                LocaleKeys.downloadWaybill.tr, 16, AppColors.primaryColor),
          ),
        )
      ],
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Text(
      str,
      textAlign: TextAlign.center,
      style: AppThemeState().customTextStyle(
          fontSize: fontSize,
          color: color,
          fontWeightType: FWT.regular,
          fontFamilyType: FFT.nunito),
    );
  }
}
