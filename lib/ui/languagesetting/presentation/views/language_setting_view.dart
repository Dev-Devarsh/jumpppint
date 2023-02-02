import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/languagesetting/presentation/controllers/language_settings_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';

class LanguageSettingsView
    extends GetResponsiveView<LanguageSettingsController> {
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
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.languageSettings.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Wrap(children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 700),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 100,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            onGetRadioLayout(
                                LocaleKeys.traditionalChinese.tr, 1),
                            const SizedBox(
                              height: 15,
                            ),
                            onGetRadioLayout(
                                LocaleKeys.simplifiedChinese.tr, 2),
                            const SizedBox(
                              height: 15,
                            ),
                            onGetRadioLayout(LocaleKeys.english.tr, 3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
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
        currentTab: 8,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                color: AppColors.primaryColor,
                child: CommonAppBar(
                  title: LocaleKeys.languageSettings.tr,
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
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 5),
                      child: Form(
                        key: formKey,
                        child: AnimationLimiter(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 700),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                  verticalOffset: 100,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                                children: [
                                  onGetRadioLayout(
                                      LocaleKeys.traditionalChinese.tr, 1),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onGetRadioLayout(
                                      LocaleKeys.simplifiedChinese.tr, 2),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onGetRadioLayout(LocaleKeys.english.tr, 3),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  onGetRadioLayout(title, index) {
    return Obx(
      () => controller.currentType.value == index
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 11, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SVGPath.radioSelectedIcon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = index;
                // controller.isSelectRecipientSelected.value = false;
                controller.updateLang(index);
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 11, bottom: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      SVGPath.radioUnSelectedIcon,
                      color: AppColors.stateDisableColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
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
