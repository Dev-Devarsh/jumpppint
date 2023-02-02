import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../../../batchcreate/presentation/controllers/batch_create_controller.dart';

class BulkOrderPreviewView extends GetResponsiveView<BatchCreateController> {
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
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.batchCreate.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.disableColor,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            PNGPath.dummyBulkOrder,
                          ),
                          onCommonTextFormField(
                              LocaleKeys.bulkOrderPreviewLbl.tr,
                              16,
                              AppColors.textPrimaryColor),
                          const SizedBox(
                            height: 15,
                          ),
                          onCommonTextFormField(
                              LocaleKeys.updatedAt
                                  .trParams({'updatedAt': '2022-01-08'}),
                              14,
                              AppColors.textSecondaryColor),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          onGetSignInButton(LocaleKeys.downloadXlsx.tr,
                              AppColors.appBarColor, AppColors.whiteColor),
                          const SizedBox(
                            height: 8,
                          ),
                          onGetSignInButton(LocaleKeys.listPickupLbl.tr,
                              AppColors.backgroundColor, AppColors.appBarColor),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
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
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 2,
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              PreferredSize(
                preferredSize: Size(Get.width, 50),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/4.8),
                  color: AppColors.primaryColor,
                  child: CommonAppBar(
                    title: LocaleKeys.batchCreate.tr,
                    elevation: 0.0,
                    isBackButtonVisible: true,
                    leadingWidth: 50,
                    centerTitle: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: Get.width / 2.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.disableColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            PNGPath.dummyBulkOrder,
                          ),
                          onCommonTextFormField(
                              LocaleKeys.bulkOrderPreviewLbl.tr,
                              16,
                              AppColors.textPrimaryColor),
                          const SizedBox(
                            height: 15,
                          ),
                          onCommonTextFormField(
                              LocaleKeys.updatedAt
                                  .trParams({'updatedAt': '2022-01-08'}),
                              14,
                              AppColors.textSecondaryColor),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //
                      child: Column(
                        children: [
                          onGetSignInButton(LocaleKeys.downloadXlsx.tr,
                              AppColors.appBarColor, AppColors.whiteColor),
                          const SizedBox(
                            height: 10,
                          ),
                          onGetSignInButton(LocaleKeys.listPickupLbl.tr,
                              AppColors.backgroundColor, AppColors.appBarColor),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
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

  onGetSignInButton(String str, Color color, Color txtColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CommonButton(
        buttonText: str,
        width: Get.width,
        backgroundColor: color,
        isBorder: false,
        textColor: txtColor,
        onTap: () {
          if (formKey.currentState!.validate()) {
            Logger.dev("Done Button Tap");
          } else {
            Logger.dev("Done Validate Failed");
          }
        },
      ),
    );
  }

}
