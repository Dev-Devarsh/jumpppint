import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../controllers/apply_for_account_controller.dart';

class ApplyForAccountView extends GetResponsiveView<ApplyForAccountController> {
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
          title: LocaleKeys.registration.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        key: formKey,
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 700),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 100,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                            children: [
                              onGetNameTextFormField(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetEmailTextFormField(),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 35,
                                      child: onGetAreaCodeTextFormField()),
                                  Expanded(
                                      flex: 65,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: onGetMobileTextFormField(),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetCompanyNameTextFormField(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetKnowUsDropDown(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetRemarksTextFormField(),
                            ],)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              onGetNextButton(false),
              const SizedBox(
                height: 5,
              ),
              onGetFAQButton(),
            ],
          ),
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
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              color: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
              child: CommonAppBar(
                title: LocaleKeys.registration.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                centerTitle: true,
              ),
            ),
          ),
          body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: Get.width/3.5, vertical: 15),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Form(
                          key: formKey,
                          child: AnimationLimiter(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 700),
                                childAnimationBuilder: (widget) => SlideAnimation(
                                  verticalOffset: 100,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                              children: [
                                onGetNameTextFormField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                onGetEmailTextFormField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 35,
                                        child:
                                            onGetAreaCodeTextFormField()),
                                    Expanded(
                                        flex: 65,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12),
                                          child: onGetMobileTextFormField(),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                onGetCompanyNameTextFormField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                onGetKnowUsDropDown(),
                                const SizedBox(
                                  height: 15,
                                ),
                                onGetRemarksTextFormField(),
                              ],)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width/3.5, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      children: [
                        onGetNextButton(true),
                        const SizedBox(
                          height: 5,
                        ),
                        onGetFAQButton(),
                      ],
                    ),
                  )
                ],
              )),
    );
  }


  onGetNameTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConName,
      focusNode: controller.focusName,
      labelText: LocaleKeys.name.tr,
      textInputType: TextInputType.name,
      onChange: (value) {
        controller.name.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }

  onGetCompanyNameTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConCompanyName,
      focusNode: controller.focusCompanyName,
      labelText: LocaleKeys.companyName.tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.name,
      onChange: (value) {
        controller.companyName.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.emptyCompanyNameValidator(value);
      },
    );
  }

  onGetEmailTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConEmail,
      focusNode: controller.focusEmail,
      labelText: LocaleKeys.email.tr,
      textInputType: TextInputType.emailAddress,
      onChange: (value) {
        controller.email.value = value ?? '';
        Logger.dev("@309 Register API call");
      },
      onValidate: (value) {
        return Validator.emailValidator(value);
      },
    );
  }

  onGetAreaCodeTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConAreaCode,
      focusNode: controller.focusAreaCode,
      labelText: LocaleKeys.areaCode.tr,
      textInputType: TextInputType.numberWithOptions(signed: true),
      onChange: (value) {
        controller.areaCode.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }

  onGetMobileTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConMobile,
      focusNode: controller.focusMobile,
      labelText: LocaleKeys.mobile.tr,
      textInputType: TextInputType.numberWithOptions(signed: true),
      onChange: (value) {
        controller.mobile.value = value ?? '';
      },
      onValidate: (value) {
        //return Validator.phoneNumberValidator(value);
      },
    );
  }

  onGetRemarksTextFormField() {
    return CustomTextFormField(
      isAlignLabelWithHint: true,
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConRemarks,
      focusNode: controller.focusRemarks,
      labelText: LocaleKeys.remarks.tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.multiline,
      maxLines: 5,
      contentPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 0),
      minLines: 5,
      onChange: (value) {
        controller.remarks.value = value ?? '';
      },
      onValidate: (value) {
        //return Validator.emptyRemarksValidator(value);
      },
    );
  }

  final List<Map<String, dynamic>> _roles = [
    {"name": "Super Admin", "index": 1},
    {"name": "Admin", "index": 2},
    {"name": "Manager", "index": 3},
    {"name": "Technician", "index": 4},
    {"name": "Customer Support", "index": 5},
    {"name": "User", "index": 6},
  ];

  onGetKnowUsDropDown() {
    return Obx(
      () => DropdownFormField<Map<String, dynamic>>(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
          errorMaxLines: 1,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.textSecondaryColor,
            ),
          ),
          errorStyle: !controller.knowUsError.value
              ? AppThemeState().errorStyle(0)
              : AppThemeState().errorStyle(12),
          labelText: LocaleKeys.howDidYouKnowUs.tr,
          labelStyle: AppThemeState().dropdownLabelStyle(),
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder: AppThemeState().enableBorderStyle(),
          focusedBorder: AppThemeState().focusBorderStyle(),
          border: AppThemeState().borderStyle(),
          errorBorder: !controller.knowUsError.value
              ? AppThemeState().errorBorderStyle(AppColors.primaryColor)
              : AppThemeState().errorBorderStyle(AppColors.borderColor),
        ),
        controller: controller.knowUsController.value,
        onChanged: (dynamic str) {
          if (str != null) {
            controller.knowUs.value = true;
            controller.knowUsError.value = true;
          } else {
            controller.knowUsError.value = false;
          }
        },
        displayItemFn: (dynamic item) => onGetDisplayItem(item),
        findFn: (dynamic str) async => _roles,
        filterFn: (dynamic item, str) =>
            item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, position, focused,
                dynamic lastSelectedItem, onTap) =>
            onGetDropDownItem(item, position, focused, lastSelectedItem, onTap),
      ),
    );
  }

  onGetNextButton(bool isFromWeb) {
    return Obx(
      () => CommonButton(
        buttonText: LocaleKeys.nextApplyForAccount.tr,
        width: Get.width,
        // backgroundColor: AppColors.disableColor,
        backgroundColor: controller.email.value.isNotEmpty &&
                controller.name.value.isNotEmpty &&
                controller.areaCode.value.isNotEmpty &&
                controller.mobile.value.isNotEmpty &&
                controller.companyName.value.isNotEmpty
            ? AppColors.primaryColor
            : AppColors.disableColor,
        textColor: controller.email.value.isNotEmpty &&
                controller.name.value.isNotEmpty &&
                controller.areaCode.value.isNotEmpty &&
                controller.mobile.value.isNotEmpty &&
                controller.companyName.value.isNotEmpty
            ? AppColors.whiteColor
            : AppColors.lightGreyColor,
        isBorder: false,
        onTap: () {
          if (controller.email.value.isNotEmpty &&
              controller.name.value.isNotEmpty &&
              controller.areaCode.value.isNotEmpty &&
              controller.mobile.value.isNotEmpty &&
              controller.companyName.value.isNotEmpty) {
            if (formKey.currentState!.validate()) {
              Get.toNamed(RouteName.applyForAccountPassword);
            }
            controller.onDropDownValueCheck();
          } else {
            Logger.dev("@151 Validate Failed");
          }
        },
      ),
    );
  }

  onGetFAQButton() {
    return CommonButton(
      buttonText: LocaleKeys.faq.tr,
      width: Get.width,
      backgroundColor: Colors.transparent,
      isBorder: false,
      textColor: AppColors.primaryColor,
      onTap: () {
        // if (formKey.currentState!.validate()) {
        //   Logger.dev("@149 Login Button Tap");
        // } else {
        //   Logger.dev("@151 Validate Failed");
        // }
      },
    );
  }

  onGetDropDownItem(
      dynamic item, position, focused, dynamic lastSelectedItem, onTap) {
    return ListTile(
      title: Text(
        item['name'],
        style: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
      ),
      tileColor:
          focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
      onTap: onTap,
    );
  }

  onGetDisplayItem(item) {
    return Text(
      item != null ? item['name'] : '',
      style: AppThemeState().customTextStyle(
          fontSize: 14,
          fontFamilyType: FFT.nunito,
          color: AppColors.textPrimaryColor,
          fontWeightType: FWT.regular),
    );
  }
}
