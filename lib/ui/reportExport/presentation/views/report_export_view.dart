import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/reportExport/presentation/controllers/report_export_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../routes.dart';

class ReportExportView extends GetResponsiveView<ReportExportController> {
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
          title: LocaleKeys.reportExport.tr,
          elevation: 0.0,
          isBackButtonVisible: false,
          leading: onGetBackIcon(),
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      drawer: Drawer(
        child: CommonDrawer(currentIndex: RxInt(3), onLogoutClick: () {
          controller.logout();
        },),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
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
                            childAnimationBuilder: (widget) =>
                                SlideAnimation(
                                  verticalOffset: 50,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                            duration: const Duration(milliseconds: 300),
                            children: [
                              onCommonTextFormField(LocaleKeys.downloadReport.tr,
                                  13, AppColors.secondaryColor),
                              const SizedBox(
                                height: 10,
                              ),
                              onGetShipmentRadioLayout(
                                  LocaleKeys.shipmentRecords.tr, 1),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetShipmentRadioLayout(
                                  LocaleKeys.balanceRecords.tr, 2),
                              const SizedBox(
                                height: 15,
                              ),
                              onCommonTextFormField(
                                  LocaleKeys.date.tr, 13, AppColors.secondaryColor),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetFromTextFormField(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetToTextFormField(),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    onConfirmButton(false),
                    onClearButton(false),
                  ],
                ),
              )
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
    return TemplateWeb(
        currentTab: 3,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              CommonAppBar(
                title: LocaleKeys.reportExport.tr,
                elevation: 0.0,
                isBackButtonVisible: false,
                leadingWidth: 27,
                centerTitle: true,
              ),
              Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Wrap(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            margin: EdgeInsets.symmetric(horizontal: Get.width/5),
                            child: AnimationLimiter(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: AnimationConfiguration.toStaggeredList(
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                        verticalOffset: 50,
                                        child: FadeInAnimation(
                                          child: widget,
                                        ),
                                      ),
                                  duration: const Duration(milliseconds: 300),
                                  children: [
                                    onCommonTextFormField(
                                        LocaleKeys.downloadReport.tr,
                                        13,
                                        AppColors.secondaryColor),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    onGetShipmentRadioLayout(
                                        LocaleKeys.shipmentRecords.tr, 1),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    onGetShipmentRadioLayout(
                                        LocaleKeys.balanceRecords.tr, 2),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    onCommonTextFormField(LocaleKeys.date.tr, 13,
                                        AppColors.secondaryColor),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    onGetFromTextFormField(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    onGetToTextFormField(),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        padding: EdgeInsets.only(top: 10, left: Get.width/5, right: Get.width/5),
                        child: Column(
                          children: [
                            onConfirmButton(true),
                            onClearButton(true),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        str,
        textAlign: TextAlign.start,
        style: AppThemeState().customTextStyle(
            fontSize: fontSize,
            color: color,
            // color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetFromTextFormField() {
    return InkWell(
        child: CustomTextFormField(
          prefixWidget: Padding(
            padding: const EdgeInsets.only(top: 11, bottom: 13),
            child: SvgPicture.asset(
              SVGPath.dateIcon,
            ),
          ),
          backgroundColor: AppColors.whiteColor,
          editController: controller.editConFrom,
          focusNode: controller.focusFrom,
          isEnabled: false,
          labelText: LocaleKeys.from.tr,
          textInputType: TextInputType.none,
          isAlignLabelWithHint: true,
          onChange: (value) {
            // controller.fromStr.value = value!;
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ),
        onTap: () async {
          final DateTime? selected = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(3000),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.appBarColor,
                    onPrimary: AppColors.whiteColor,
                    onSurface: AppColors.appBarColor,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: AppColors.appBarColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (selected != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(selected);
            controller.fromStr.value = true;
            controller.editConFrom.text = formattedDate;
            controller.editConTo.text = "";
          } else {
            print("Date is not selected");
          }
        });
  }

  onGetToTextFormField() {
    return InkWell(
        child: CustomTextFormField(
          prefixWidget: Padding(
            padding: const EdgeInsets.only(top: 11, bottom: 13),
            child: SvgPicture.asset(
              SVGPath.dateIcon,
            ),
          ),
          backgroundColor: AppColors.whiteColor,
          editController: controller.editConTo,
          focusNode: controller.focusTo,
          isEnabled: false,
          labelText: LocaleKeys.to.tr,
          textInputType: TextInputType.none,
          onChange: (value) {
            // controller.toStr.value = value!;
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ),
        onTap: () async {

          if(controller.editConFrom.text == ""){
            ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('plaese select from date'),
            ));

          }else{
            final DateTime? selected = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              // firstDate: DateTime.now().subtract(Duration(days: 0)),
              firstDate: DateTime.parse(controller.editConFrom.text).subtract(Duration(days: 0)),
              lastDate: DateTime(3000),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.appBarColor,
                      onPrimary: AppColors.whiteColor,
                      onSurface: AppColors.appBarColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppColors.appBarColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selected != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(selected);
              controller.editConTo.text = formattedDate;
              controller.toStr.value = true;

            } else {
              print("Date is not selected");
            }
          }


        }
    );
  }

  onGetShipmentRadioLayout(title, index) {
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
            ).paddingOnly(bottom: 2),
          ],
        ),
      )
          : InkWell(
        onTap: () {
          controller.currentType.value = index;
          controller.isSelectSenderFilled.value = false;
          // controller.isSelectRecipientSelected.value = false;
        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: AppThemeState().commonBorder()),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                SVGPath.radioUnSelectedIcon,
                color: AppColors.textPrimaryColor,
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
              ).paddingOnly(bottom: 2),
            ],
          ),
        ),
      ),
    );
  }

  onConfirmButton(bool isWeb) {
    return Obx(() => CommonButton(
      padding: EdgeInsets.all(0),
      buttonText: LocaleKeys.confirm.tr,
      width: Get.width,
      backgroundColor: controller.fromStr.value == true &&
          controller.toStr.value == true &&
          controller.currentType.value != 0
          ? AppColors.primaryColor
          : AppColors.disableColor,
      isBorder: false,
      textColor: controller.fromStr.value == true &&
          controller.toStr.value == true &&
          controller.currentType.value != 0
          ? AppColors.whiteColor
          : AppColors.lightGreyColor,
      onTap: () {
        if (controller.fromStr.value == true &&
            controller.toStr.value == true &&
            controller.currentType.value != 0 &&
            formKey.currentState!.validate()) {
          if(controller.currentType.value == 1){
            controller.getExportShipmentRecord(isWeb);
          }else{
          controller.getExportBalanceRecord(isWeb);
          }
          // Get.offNamed(
          //   RouteName.homePage,
          // );
        } else {
          Logger.dev("@151 Validate Failed");
        }
      },
    ));
  }

  onClearButton(bool isWeb) {
    return CommonButton(
      width: isWeb == true ? Get.width / 3 : Get.width,
      buttonText: LocaleKeys.reset.tr,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.whiteColor,
      isBorder: false,
      textColor: AppColors.appBarColor,
      onTap: () {
        controller.fromStr.value = false;
        controller.toStr.value = false;
        controller.currentType.value = 0;
        controller.editConFrom.text = "";
        controller.editConTo.text = "";
      },
    );
  }

  onGetBackIcon() {
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
}