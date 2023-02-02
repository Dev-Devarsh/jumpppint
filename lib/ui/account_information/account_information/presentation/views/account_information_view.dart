import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/generated/locales.g.dart';
import '../../../../common/common_app_bar.dart';
import '../../../../common/template_web.dart';
import '../../../../widgets/common_button.dart';
import '../controllers/account_information_controller.dart';

class AccountInformationView
    extends GetResponsiveView<AccountInformationController> {
  final AppThemeState _appTheme = AppThemeState();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.accountInformation.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 27,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: accountDetaile(),
                ),
              ),
            ),
          ),
          onGetBottomBar()
        ],
      )),
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 8,
        body: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                title: LocaleKeys.accountInformation.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 27,
                centerTitle: true,
              ),
            ),
          ),
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 5, vertical: 25),
                      child: accountDetaile(),
                    ),
                  ),
                ),
              ),
              onGetBottomBar()
            ],
          )),
        ));
  }

  accountDetaile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: AnimationLimiter(
          child: Obx(() => Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 300),
                  childAnimationBuilder: (widget) => FadeInAnimation(
                    child: widget,
                  ),
                  children: [
                    onGetAccountInformation(LocaleKeys.name.tr,
                        controller.userData.value?.name ?? ""),
                    const SizedBox(height: 15),
                    onGetAccountInformation(LocaleKeys.email.tr,
                        controller.userData.value?.email ?? ""),
                    const SizedBox(height: 15),
                    onGetAccountInformation(LocaleKeys.phoneNumber.tr,
                        controller.userData.value?.phone ?? ""),
                    const SizedBox(height: 15),
                    onGetAccountInformation(LocaleKeys.companyName.tr,
                        controller.userData.value?.merchant.name ?? ""),
                  ],
                ),
              ))),
    );
  }

  onGetAccountInformation(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.secondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          info,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ],
    );
  }

  onGetBottomBar() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          AppThemeState().commonBoxShadow(),
        ],
      ),
      padding: screen.isDesktop
          ? EdgeInsets.symmetric(vertical: 10, horizontal: Get.width / 5)
          : const EdgeInsets.all(10),
      child: Column(
        children: [
          CommonButton(
            buttonText: LocaleKeys.updateInfo.tr,
            width: Get.width,
            backgroundColor: AppColors.primaryColor,
            isBorder: false,
            textColor: AppColors.whiteColor,
            onTap: () {
              controller.goTOUpdateInfoView();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CommonButton(
            buttonText: LocaleKeys.deleteAccount.tr,
            width: Get.width,
            backgroundColor: AppColors.whiteColor,
            isBorder: false,
            textColor: AppColors.primaryColor,
            onTap: () {
              controller.goToDeleteAccountView();
            },
          ),
        ],
      ),
    );
  }
}
