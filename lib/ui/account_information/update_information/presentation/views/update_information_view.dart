import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

import '../../../../../routes.dart';
import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/generated/locales.g.dart';
import '../../../../../utills/validator.dart';
import '../../../../common/common_app_bar.dart';
import '../../../../common/template_web.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../controllers/update_information_controller.dart';

class UpdateInfrormationView
    extends GetResponsiveView<UpdateInformationController> {
  final AppThemeState _appTheme = AppThemeState();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.updateInformation.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
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
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: onGetAccountDetails())
                  ],
                ),
              ),
            ),
            onGetBottomBar()
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
      body: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.updateInformation.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 50,
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
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 5, vertical: 15),
                          child: onGetAccountDetails())
                    ],
                  ),
                ),
              ),
              onGetBottomBar()
            ],
          ),
        ),
      ),
    );
  }

  onGetAccountDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: Form(
        key: formKey,
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
              onGetFirstNameTextFormField(),
              const SizedBox(height: 15),
              onGetEmailTextField(),
              const SizedBox(height: 15),
              onGetPhoneNumberTextField(),
              const SizedBox(height: 15),
              onGetCompanyNameTextField(),
            ],
          ),
        )),
      ),
    );
  }

  onGetFirstNameTextFormField() {
    return CustomTextFormField(
      editController: controller.firstNameCon,
      focusNode: controller.focusFirstName,
      labelText: LocaleKeys.name.tr,
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.done,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }


  onGetEmailTextField() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.disableColor,
      ),
      child: Text(
        controller.userData.value?.email ?? "",
        style: TextStyle(color: AppColors.textSecondaryColor),
      ),
    );
  }

  onGetPhoneNumberTextField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            // width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.disableColor,
            ),
            child: Text(
              '852',
              style: TextStyle(color: AppColors.textSecondaryColor),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 3,
          child: Container(
            // width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.disableColor,
            ),
            child: Text(
              controller.userData.value?.phone ?? "",
              style: TextStyle(color: AppColors.textSecondaryColor),
            ),
          ),
        ),
      ],
    );
  }

  onGetCompanyNameTextField() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.disableColor,
      ),
      child: Text(
        controller.userData.value?.merchant.name ?? "",
        style: TextStyle(color: AppColors.textSecondaryColor),
      ),
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
            buttonText: LocaleKeys.save.tr,
            width: Get.width,
            backgroundColor: AppColors.primaryColor,
            isBorder: false,
            textColor: AppColors.whiteColor,
            onTap: () {
              if (formKey.currentState!.validate()) {
                //Get.toNamed(RouteName.accountInfoPage);
                controller.updateInfo();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CommonButton(
            buttonText: LocaleKeys.reset.tr,
            width: Get.width,
            backgroundColor: AppColors.whiteColor,
            isBorder: false,
            textColor: AppColors.primaryColor,
            onTap: () {
              controller.firstNameCon.text = '';
            },
          ),
        ],
      ),
    );
  }
}
