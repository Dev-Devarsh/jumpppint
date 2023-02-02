import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/settings/presentation/controllers/settings_controller.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

class SettingsView extends GetResponsiveView<SettingsController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
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
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.settings.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetMenuIcon(),
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        drawer: Drawer(
          child: CommonDrawer(currentIndex: RxInt(8), onLogoutClick: () {
            controller.logout();
          },),
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  color: AppColors.backgroundColor,
                  child: AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 700),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 100,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          SizedBox(height: 15),
                          onGetSettingButton(),
                          SizedBox(height: 15),
                          onGetNotificationButton(),
                          SizedBox(height: 15),
                          onGetLanguageSettingButton(),
                          SizedBox(height: 15),
                          onGetUpdateButton()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        key: scaffoldKey,
        currentTab: 8,
        body: Column(
          children: [
            PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: CommonAppBar(
                title: LocaleKeys.settings.tr,
                elevation: 0.0,
                isBackButtonVisible: false,
                // leading: onGetMenuIcon(),
                leadingWidth: 30,
                centerTitle: true,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: Get.width / 2.8,
                      color: AppColors.backgroundColor,
                      child: AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 700),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 100,
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                            children: [
                              SizedBox(height: 15),
                              onGetSettingButton(),
                              SizedBox(height: 15),
                              onGetNotificationButton(),
                              SizedBox(height: 15),
                              onGetLanguageSettingButton(),
                              SizedBox(height: 15),
                              onGetUpdateButton()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget onGetMenuIcon() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SvgPicture.asset(
          SVGPath.drawerIcon,
          color: AppColors.whiteColor,
        ),
      ),
      onTap: () {
        scaffoldKey.currentState!.openDrawer();
      },
    );
  }

  onGetSettingButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.accountInfoPage);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            LocaleKeys.accountInformation.tr,
            textAlign: TextAlign.left,
            style: AppThemeState().customTextStyle(
                fontSize: 17,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
      ),
    );
  }

  onGetNotificationButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.notificationSettings);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            LocaleKeys.notificationSettings.tr,
            textAlign: TextAlign.left,
            style: AppThemeState().customTextStyle(
                fontSize: 17,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
      ),
    );
  }

  onGetLanguageSettingButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.languageSettings);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            LocaleKeys.languageSettings.tr,
            textAlign: TextAlign.left,
            style: AppThemeState().customTextStyle(
                fontSize: 17,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
      ),
    );
  }

  onGetUpdateButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.updatePassword);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            LocaleKeys.updatePass.tr,
            textAlign: TextAlign.left,
            style: AppThemeState().customTextStyle(
                fontSize: 17,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
      ),
    );
  }
}
