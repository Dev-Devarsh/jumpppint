import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/controllers/type_controller.dart';

import '../../../../../../utills/app_theme.dart';
import '../../../../../../utills/asset_images.dart';
import '../../../../../../utills/colors.dart';
import '../../../../../../utills/enum/font_type.dart';
import '../../../../../../utills/generated/locales.g.dart';
import '../../../../../../utills/utils.dart';
import '../../../../../../utills/validator.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../widgets/common_button.dart';
import '../../../../../widgets/common_textformfield.dart';

class SenderInfoView extends GetResponsiveView<TypeController> {
  final String text;

  SenderInfoView({Key? key, required this.text}) : super(key: key);
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
      key: formKey,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: controller.isCreateShipment.value
              ? LocaleKeys.createShipment.tr
              : controller.isAddNewSender.value
                  ? 'Update Sender'
                  : 'Update Recipient',
          elevation: 0.0,
          isBackButtonVisible: false,
          leading: onGetCloseIcon(),
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: senderInfo()),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 35),
                child: controller.isCreateShipment.value
                    ? onGetDoneButton()
                    : onGetSaveAndDeleteButtons()),
          ],
        ),
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
      key: formKey,
      currentTab: 1,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
            child: CommonAppBar(
              title: controller.isCreateShipment.value
                  ? LocaleKeys.createShipment.tr
                  : controller.isAddNewSender.value
                      ? 'Update Sender'
                      : 'Update Recipient',
              elevation: 0.0,
              isBackButtonVisible: false,
              leading: onGetCloseIcon(),
              leadingWidth: 50,
              centerTitle: true,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 15),
                      child: senderInfo()),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 35),
                      child: controller.isCreateShipment.value
                          ? onGetDoneButton()
                          : onGetSaveAndDeleteButtons()),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  onGetCloseIcon() {

    return InkWell(
      onTap: () {
        screen.isDesktop
            ? Utils.showCommonDialogWeb(
                title: LocaleKeys.quitWithUnsavedChanges.tr,
                positiveText: LocaleKeys.confirm.tr,
                negativeText: LocaleKeys.cancel.tr,
                isNegativeButtonShow: true,
                onNegativeTap: () {
                  Get.back();
                },
                onTap: () {
                  if (controller.isCreateShipment.value) {
                    controller.isCreateShipment.value = false;
                    controller.senderNameCon.clear();
                    controller.regionCodeCon.clear();
                    controller.mobileNoCon.clear();
                    controller.flatOrRoomCon.clear();
                    controller.floorCon.clear();
                    controller.buildingOrStreetNoCon.clear();
                  } else {
                    controller.isCreateShipment.value;
                  }
                  Get.back();
                  Get.back();
                })
            : Utils.showCommonDialog(
                title: LocaleKeys.quitWithUnsavedChanges.tr,
                positiveText: LocaleKeys.confirm.tr,
                negativeText: LocaleKeys.cancel.tr,
                isNegativeButtonShow: true,
                onNegativeTap: () {
                  Get.back();
                },
                onTap: () {
                  Get.back();
                  Get.back();
                });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SvgPicture.asset(
          SVGPath.closeIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  senderInfo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: Column(
        children: [
          onGetSenderInfoText(),
          const SizedBox(height: 17),
          onGetSenderNameTextField(),
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
        ],
      ),
    );
  }

  onGetSenderInfoText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: controller.isCreateShipment.value
          ? Text(
              controller.isAddNewSender.value
                  ? LocaleKeys.senderInfo.tr
                  : 'Recipient Info',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            )
          : Text(
              controller.isAddNewSender.value
                  ? LocaleKeys.sender.tr
                  : LocaleKeys.recipient.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
    );
  }

  onGetSenderNameTextField() {
    return CustomTextFormField(
      maxLength: 20,
      backgroundColor: AppColors.whiteColor,
      editController: controller.senderNameCon,
      focusNode: controller.focusSenderNam,
      labelText: controller.isAddNewSender.value
          ? LocaleKeys.senderName.tr
          : LocaleKeys.recipientName.tr,
      textInputType: TextInputType.name,
      onChange: (value) {
        controller.charLengthSenderName.value =
            value != null ? value.length : 0;
      },
      onValidate: (value) {
        return Validator.usernameValidator(value);
      },
    );
  }

  onGetSenderNameLengthCount() {
    return Container(
      alignment: Alignment.centerRight,
      child: Obx(() => Text(
            '${controller.charLengthSenderName}/20',
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
            child: CustomTextFormField(
              backgroundColor: AppColors.whiteColor,
              editController: controller.regionCodeCon,
              focusNode: controller.focusRegionCode,
              labelText: LocaleKeys.regionCode.tr,
              textInputType: TextInputType.number,
              onChange: (value) {},
              onValidate: (value) {},
            ),
          ),
        ),
        const SizedBox(width: 7),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.disableColor,
            ),
            child: CustomTextFormField(
              backgroundColor: AppColors.whiteColor,
              editController: controller.mobileNoCon,
              focusNode: controller.focusMobileNo,
              labelText: LocaleKeys.mobileNumber.tr,
              textInputType: TextInputType.number,
              onChange: (value) {},
              onValidate: (value) {
                return Validator.phoneNumberValidator(value);
              },
            ),
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.disableColor,
                ),
                child: CustomTextFormField(
                  backgroundColor: AppColors.whiteColor,
                  maxLength: 10,
                  editController: controller.flatOrRoomCon,
                  focusNode: controller.focusFlatOrRoom,
                  labelText: LocaleKeys.flatOrRoom.tr,
                  textInputType: TextInputType.name,
                  onChange: (value) {
                    controller.charLengthFlat.value =
                        value != null ? value.length : 0;
                  },
                  onValidate: (value) {},
                ),
              ),
              const SizedBox(height: 7),
              onGetFlatNameLengthCount()
            ],
          ),
        ),
        const SizedBox(width: 7),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.disableColor,
                ),
                child: CustomTextFormField(
                  backgroundColor: AppColors.whiteColor,
                  maxLength: 10,
                  editController: controller.floorCon,
                  focusNode: controller.focusFloor,
                  labelText: LocaleKeys.floor.tr,
                  textInputType: TextInputType.name,
                  onChange: (value) {
                    controller.charLengthFloor.value =
                        value != null ? value.length : 0;
                  },
                  onValidate: (value) {},
                ),
              ),
              const SizedBox(height: 7),
              onGetFloorNameLengthCount()
            ],
          ),
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
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.searchAddressPage);
      },
      child: TextFormField(
        controller: controller.buildingOrStreetNoCon,
        focusNode: controller.focusbuildingOrStreetNo,
        enabled: false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
          hintText: text,
          label: text != " " ? Text(text) : null,
          labelText: text != " " ? null : LocaleKeys.buildingOrStreetNo.tr,
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
          controller.buildingOrStreetNoCon.clear();
          Get.toNamed(RouteName.searchAddressPage);
        },
        validator: (value) {
          return Validator.phoneNumberValidator(value);
        },
      ),
    );
  }

  onGetDoneButton() {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.disableColor,
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: CommonButton(
        buttonText: LocaleKeys.done.tr,
        width: Get.width,
        backgroundColor: (controller.senderNameCon.text.isEmpty &&
                controller.regionCodeCon.text.isEmpty &&
                controller.mobileNoCon.text.isEmpty &&
                controller.flatOrRoomCon.text.isEmpty &&
                controller.floorCon.text.isEmpty &&
                controller.buildingOrStreetNoCon.text.isEmpty
            ? AppColors.disableColor
            : AppColors.primaryColor),
        isBorder: false,
        textColor: (controller.senderNameCon.text.isEmpty &&
                controller.regionCodeCon.text.isEmpty &&
                controller.mobileNoCon.text.isEmpty &&
                controller.flatOrRoomCon.text.isEmpty &&
                controller.floorCon.text.isEmpty &&
                controller.buildingOrStreetNoCon.text.isEmpty
            ? AppColors.stateDisableColor
            : AppColors.whiteColor),
        onTap: () {
          if (controller.senderNameCon.text.isNotEmpty &&
              controller.regionCodeCon.text.isNotEmpty &&
              controller.mobileNoCon.text.isNotEmpty &&
              controller.flatOrRoomCon.text.isNotEmpty &&
              controller.floorCon.text.isNotEmpty &&
              controller.buildingOrStreetNoCon.text.isNotEmpty) {
            controller.doAddress();
            Get.back();
          }
        },
      ),
    );
  }

  onGetSaveAndDeleteButtons() {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          CommonButton(
            buttonText: LocaleKeys.save.tr,
            width: Get.width,
            backgroundColor: (controller.saveNameCon != null
                ? AppColors.primaryColor
                : AppColors.disableColor),
            isBorder: false,
            textColor: (controller.saveNameCon != null
                ? AppColors.whiteColor
                : AppColors.stateDisableColor),
            onTap: () {
              if (controller.mobileNoCon.text.length < 10) {
                screen.isDesktop
                    ? Utils.showCommonDialogWeb(
                        title: LocaleKeys.enterValidNumber.tr,
                        positiveText: LocaleKeys.ok.tr,
                        onTap: () {
                          Get.back();
                        })
                    : Utils.showCommonDialog(
                        title: LocaleKeys.enterValidNumber.tr,
                        positiveText: LocaleKeys.ok.tr,
                        onTap: () {
                          Get.back();
                        });
              } else {
                Get.back();
              }
            },
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: CommonButton(
              buttonText: controller.isAddNewSender.value
                  ? LocaleKeys.deleteThisSender.tr
                  : 'Delete this recipient',
              width: Get.width,
              backgroundColor: AppColors.backgroundColor,
              isBorder: false,
              textColor: AppColors.primaryColor,
              onTap: () {
                if (controller.mobileNoCon.text.length < 10) {
                  screen.isDesktop
                      ? Utils.showCommonDialogWeb(
                          title: LocaleKeys.enterValidNumber.tr,
                          positiveText: LocaleKeys.ok.tr,
                          onTap: () {
                            Get.back();
                          })
                      : Utils.showCommonDialog(
                          title: LocaleKeys.enterValidNumber.tr,
                          positiveText: LocaleKeys.ok.tr,
                          onTap: () {
                            Get.back();
                          });
                } else {
                  Get.back();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
