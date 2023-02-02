import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/shipmentDone/presentation/controllers/shipment_done_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

class ShipmentDoneView extends GetResponsiveView<ShipmentDoneController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirm.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirmLbl.tr, 16,
                        AppColors.textSecondaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget? tablet() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirm.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirmLbl.tr, 16,
                        AppColors.textSecondaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirm.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.requestConfirmLbl.tr, 16,
                        AppColors.textSecondaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Center(
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: AppThemeState().customTextStyle(
            fontSize: fontSize,
            color: color,
            // color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetEmailTextFormField() {
    return CustomTextFormField(
      editController: controller.editConEmail,
      focusNode: controller.focusEmail,
      labelText: LocaleKeys.emailLabel.tr,
      textInputType: TextInputType.emailAddress,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.emailValidator(value);
      },
    );
  }

}
