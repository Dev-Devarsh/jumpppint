import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../controllers/apply_waybills_controller.dart';

class ApplyWayBillsView extends GetResponsiveView<ApplyWayBillsController> {
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
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.applyWayBills.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetMenuIcon(),
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        drawer: Drawer(
          child: CommonDrawer(
            currentIndex: RxInt(6),
            onLogoutClick: () {
              controller.logout();
            },
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
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 20, left: 15, right: 15),
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
                                      LocaleKeys.noOfWayBillsLbl.tr),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  onExpressDeliveryTextFormField(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onStandardDeliveryTextFormField(),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  onCommonTextFormField(
                                      LocaleKeys.deliveryAddLbl.tr),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  onGetNameTextField(),
                                  const SizedBox(height: 7),
                                  onGetSenderNameLengthCount(),
                                  const SizedBox(height: 17),
                                  onGetRegionAndMobileNumber(),
                                  const SizedBox(height: 7),
                                  onEnterMobileNoForSMS(),
                                  const SizedBox(height: 17),
                                  onGetFlatAndFloorInfo(),
                                  const SizedBox(height: 17),
                                  onGetBuildingOrStreetNoTextField(),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  onGetRemarksTextFormField(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      onConfirmButton(false),
                      const SizedBox(
                        height: 5,
                      ),
                      onResetButton(),
                    ],
                  ),
                ),
              ),
            ],
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
        currentTab: 6,
        alignment: AlignmentDirectional.topCenter,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 292),
                color: AppColors.primaryColor,
                child: CommonAppBar(
                  title: LocaleKeys.applyWayBills.tr,
                  elevation: 0.0,
                  isBackButtonVisible: false,
                  leadingWidth: 50,
                  centerTitle: true,
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width / 5, vertical: 10),
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 20, left: 15, right: 15),
                    child: Form(
                      key: formKey,
                      child: AnimationLimiter(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: AnimationConfiguration.toStaggeredList(
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 50,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              duration: const Duration(milliseconds: 300),
                              children: [
                                onCommonTextFormField(
                                    LocaleKeys.noOfWayBillsLbl.tr),
                                const SizedBox(
                                  height: 10,
                                ),
                                onExpressDeliveryTextFormField(),
                                const SizedBox(
                                  height: 15,
                                ),
                                onStandardDeliveryTextFormField(),
                                const SizedBox(
                                  height: 25,
                                ),
                                onCommonTextFormField(
                                    LocaleKeys.deliveryAddLbl.tr),
                                const SizedBox(
                                  height: 10,
                                ),
                                onGetNameTextField(),
                                const SizedBox(height: 7),
                                onGetSenderNameLengthCount(),
                                const SizedBox(height: 17),
                                onGetRegionAndMobileNumber(),
                                const SizedBox(height: 7),
                                onEnterMobileNoForSMS(),
                                const SizedBox(height: 17),
                                onGetFlatAndFloorInfo(),
                                const SizedBox(height: 17),
                                onGetBuildingOrStreetNoTextField(),
                                const SizedBox(
                                  height: 25,
                                ),
                                onGetRemarksTextFormField(),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
              ),
              padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: Get.width / 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  onConfirmButton(true),
                  const SizedBox(
                    height: 5,
                  ),
                  onResetButton(),
                ],
              ),
            )
          ],
        ));
  }

  onCommonTextFormField(String str) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        str,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        style: AppThemeState().customTextStyle(
            fontSize: 14,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
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

  onExpressDeliveryTextFormField() {
    return Obx(() => CustomTextFormField(
          backgroundColor: AppColors.whiteColor,
          editController: controller.editExpressDelivery.value,
          focusNode: controller.focusExpressDelivery,
          labelText: LocaleKeys.expressDeliveryWayBills.tr,
          textInputType: TextInputType.phone,
          maxLength: 20,
          onChange: (value) {
            Logger.dev(value as String);
            controller.expressDelivery.value = value;
            controller.labelRequestItem.sameDayDeliveryQuantity =
                double.parse(value);
            print(
                "CustomTextFormField---- ${controller.labelRequestItem.sameDayDeliveryQuantity}");
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ));
  }

  onStandardDeliveryTextFormField() {
    return Obx(() => CustomTextFormField(
          backgroundColor: AppColors.whiteColor,
          editController: controller.editStandardDelivery.value,
          focusNode: controller.focusStandard,
          labelText: LocaleKeys.standardDeliveryWayBills.tr,
          textInputType: TextInputType.phone,
          maxLength: 20,
          onChange: (value) {
            Logger.dev(value as String);
            controller.standardDelivery.value = value;
            controller.labelRequestItem.standardDeliveryQuantity =
                double.parse(value);
            print(
                "CustomTextFormField---- ${controller.labelRequestItem.standardDeliveryQuantity}");
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ));
  }

  onAddressTextFormField() {
    return Obx(() => CustomTextFormField(
          backgroundColor: AppColors.whiteColor,
          editController: controller.editAddress.value,
          focusNode: controller.focusAddress,
          labelText: LocaleKeys.address.tr,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.streetAddress,
          onChange: (value) {
            Logger.dev(value as String);
            // controller.address.value = value;
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ));
  }

  onGetRemarksTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        counterStyle: TextStyle(color: AppColors.textSecondaryColor),
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
        errorMaxLines: 3,
        alignLabelWithHint: true,
        prefix: const Offstage(),
        errorStyle: AppThemeState().customTextStyle(
            fontSize: 12,
            fontFamilyType: FFT.nunito,
            color: AppColors.primaryColor,
            fontWeightType: FWT.regular),
        labelText: LocaleKeys.remarks.tr,
        labelStyle: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
        filled: true,
        fillColor: AppColors.whiteColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
      ),
      controller: controller.editConRemarks.value,
      focusNode: controller.focusRemarks,
      keyboardType: TextInputType.multiline,
      maxLength: 250,
      textInputAction: TextInputAction.done,
      maxLines: 5,
      minLines: 5,
      onChanged: (value) {
        Logger.dev(value as String);
        controller.remarks.value = value;
        controller.labelRequestItem.merchantRemarks = value;
        print(
            "CustomTextFormField---- ${controller.labelRequestItem.merchantRemarks}");
      },
      validator: (value) {
        return Validator.emptyValidator(value);
      },
    );

    /* return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConRemarks,
      focusNode: controller.focusRemarks,
      labelText: LocaleKeys.remarks.tr,
      textInputType: TextInputType.multiline,
      maxLength: 250,
      maxLines: 5,
      counter: null,
      contentPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
      minLines: 5,
      isAlignLabelWithHint: true,
      onChange: (value) {
        Logger.dev(value as String);
        controller.remarks.value = value;
      },
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );*/
  }

  onConfirmButton(bool isFromWeb) {
    return CommonButton(
      buttonText: LocaleKeys.confirm.tr,
      width: Get.width,
      backgroundColor: (controller.editStandardDelivery.value.text.isEmpty &&
              controller.editExpressDelivery.value.text.isEmpty &&
              controller.editConRemarks.value.text.isEmpty &&
              controller.nameCon.value.text.isEmpty &&
              controller.mobileNoCon.value.text.isEmpty &&
              controller.regionCodeCon.value.text.isEmpty &&
              controller.flatOrRoomCon.value.text.isEmpty &&
              controller.floorCon.value.text.isEmpty &&
              controller.buildingOrStreetNoCon.value.text.isEmpty)
          ? AppColors.disableColor
          : AppColors.primaryColor,
      isBorder: false,
      textColor: (controller.editStandardDelivery.value.text.isEmpty &&
              controller.editExpressDelivery.value.text.isEmpty &&
              controller.editConRemarks.value.text.isEmpty &&
              controller.nameCon.value.text.isEmpty &&
              controller.mobileNoCon.value.text.isEmpty &&
              controller.regionCodeCon.value.text.isEmpty &&
              controller.flatOrRoomCon.value.text.isEmpty &&
              controller.floorCon.value.text.isEmpty &&
              controller.buildingOrStreetNoCon.value.text.isEmpty)
          ? AppColors.lightGreyColor
          : AppColors.whiteColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          Logger.dev("@450 Confirm Button Tap");
          controller.doLabelRequest();
          Get.offNamed(RouteName.homePage);
        }
      },
    );
  }

  onGetNameTextField() {
    return Obx(() => CustomTextFormField(
          backgroundColor: AppColors.whiteColor,
          maxLength: 20,
          editController: controller.nameCon.value,
          focusNode: controller.focusSenderNam,
          labelText: LocaleKeys.name.tr,
          textInputType: TextInputType.name,
          onChange: (value) {
            controller.charLengthName.value = value != null ? value.length : 0;
            controller.name.value = value ?? "";
            controller.labelRequestItem.createAddress.address.contactName = value;
            print("CustomTextFormField---- $value ${controller.labelRequestItem.createAddress.address.contactName}");
          },
          onValidate: (value) {
            return Validator.emptyValidator(value);
          },
        ));
  }

  onGetSenderNameLengthCount() {
    return Container(
      alignment: Alignment.centerRight,
      child: Obx(() => Text(
            '${controller.charLengthName}/20',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          )),
    );
  }

  onGetRegionAndMobileNumber() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.disableColor,
            ),
            child: Obx(() => CustomTextFormField(
                  backgroundColor: AppColors.whiteColor,
                  editController: controller.regionCodeCon.value,
                  focusNode: controller.focusRegionCode,
                  labelText: LocaleKeys.regionCode.tr,
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    controller.regionCode.value = value ?? "";
                    controller.labelRequestItem.createAddress.address.regionCode = value;
                    print(
                        "CustomTextFormField---- ${controller.labelRequestItem.createAddress.address.regionCode}");
                  },
                  onValidate: (value) {},
                )),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.disableColor,
            ),
            child: Obx(() => CustomTextFormField(
                  backgroundColor: AppColors.whiteColor,
                  editController: controller.mobileNoCon.value,
                  focusNode: controller.focusMobileNo,
                  labelText: LocaleKeys.mobileNumber.tr,
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    controller.mobileNumber.value = value ?? "";
                    controller.labelRequestItem.createAddress.address.contactPhone = value;
                    print(
                        "CustomTextFormField---- ${controller.labelRequestItem.createAddress.address.contactPhone}");
                  },
                  onValidate: (value) {
                    return Validator.phoneNumberValidator(value);
                  },
                )),
          ),
        ),
      ],
    );
  }

  onEnterMobileNoForSMS() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        LocaleKeys.enterMobileNoForSMS.tr,
        style: _appTheme.customTextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetFlatAndFloorInfo() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Obx(() => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.disableColor,
                    ),
                    child: CustomTextFormField(
                      backgroundColor: AppColors.whiteColor,
                      maxLength: 10,
                      editController: controller.flatOrRoomCon.value,
                      focusNode: controller.focusFlatOrRoom,
                      labelText: LocaleKeys.flatOrRoom.tr,
                      textInputType: TextInputType.name,
                      onChange: (value) {
                        controller.charLengthFlat.value =
                            value != null ? value.length : 0;
                        controller.flatOrRoom.value = value ?? "";
                        controller.labelRequestItem.createAddress.address.room = value;
                        print(
                            "CustomTextFormField---- ${controller.labelRequestItem.createAddress.address.room}");
                      },
                      onValidate: (value) {},
                    ),
                  ),
                  const SizedBox(height: 7),
                  onGetFlatNameLengthCount()
                ],
              )),
        ),
        const SizedBox(width: 6),
        Flexible(
          flex: 1,
          child: Obx(() => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.disableColor,
                    ),
                    child: CustomTextFormField(
                      backgroundColor: AppColors.whiteColor,
                      maxLength: 10,
                      editController: controller.floorCon.value,
                      focusNode: controller.focusFloor,
                      labelText: LocaleKeys.floor.tr,
                      textInputType: TextInputType.name,
                      onChange: (value) {
                        controller.charLengthFloor.value =
                            value != null ? value.length : 0;
                        controller.floor.value = value ?? "";
                        controller.labelRequestItem.createAddress.address.contactName = value;
                        print(
                            "CustomTextFormField---- ${controller.labelRequestItem.createAddress.address.contactName}");
                      },
                      onValidate: (value) {},
                    ),
                  ),
                  const SizedBox(height: 7),
                  onGetFloorNameLengthCount()
                ],
              )),
        ),
      ],
    );
  }

  onGetFlatNameLengthCount() {
    return Container(
      alignment: Alignment.centerRight,
      child: Obx(() => Text(
            '${controller.charLengthFlat}/10',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          )),
    );
  }

  onGetFloorNameLengthCount() {
    return Container(
      alignment: Alignment.centerRight,
      child: Obx(() => Text(
            '${controller.charLengthFloor}/10',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          )),
    );
  }

  onGetBuildingOrStreetNoTextField() {
    return Obx(() => InkWell(
          onTap: () {
            Get.toNamed(RouteName.searchAddressPage,
                    arguments: {"isFromeApplyWaybills": true})!
                .then((value) {
              controller.buildingOrStreetNoCon.value.text = value;
              controller.labelRequestItem.createAddress.address.address = value;
            });
          },
          child: TextFormField(
            controller: controller.buildingOrStreetNoCon.value,
            focusNode: controller.focusbuildingOrStreetNo,
            enabled: false,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              hintText: LocaleKeys.buildingOrStreetNo.tr,
              label: Text(LocaleKeys.buildingOrStreetNo.tr),
              labelStyle: AppThemeState().customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.borderColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  )),
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.borderColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  )),
            ),
            keyboardType: TextInputType.name,
            onChanged: (value) {
              controller.buildingOrStreetNo.value = value;
              controller.buildingOrStreetNoCon.value.clear();
              controller.buildingOrStreetNo.value = value;
              controller.labelRequestItem.createAddress.address.address =
                  value;
              print(
                  "CustomTextFormField---- ${controller.labelRequestItem.createAddress.address.address}");
              Get.toNamed(RouteName.searchAddressPage);
            },
            validator: (value) {
              return Validator.emptyValidator(value);
            },
          ),
        ));
  }

  onResetButton() {
    return CommonButton(
      buttonText: LocaleKeys.reset.tr,
      width: Get.width,
      backgroundColor: Colors.transparent,
      isBorder: false,
      textColor: AppColors.primaryColor,
      onTap: () {
        controller.editStandardDelivery.value.clear();
        controller.editExpressDelivery.value.clear();
        controller.editConRemarks.value.clear();
        controller.nameCon.value.clear();
        controller.mobileNoCon.value.clear();
        controller.regionCodeCon.value.clear();
        controller.flatOrRoomCon.value.clear();
        controller.floorCon.value.clear();
        controller.buildingOrStreetNoCon.value.clear();
      },
    );
  }
}
