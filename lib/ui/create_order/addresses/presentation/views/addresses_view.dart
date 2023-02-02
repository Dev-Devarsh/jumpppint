import 'dart:ui';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/create_order/common/create_order_template.dart';
import 'package:jumppoint_app/ui/create_order/common/create_order_template_web.dart';
import 'package:jumppoint_app/ui/create_order/model/address_pick_up_store_option_model.dart';
import 'package:jumppoint_app/ui/create_order/model/address_shipment_merchant_model.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/controllers/type_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/validator.dart';

class AddressesView extends GetResponsiveView<TypeController> {
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
    return CreateOrderTemplate(
      formKey: formKey,
      screen: screen,
      leadingWidth: 50,
      closeButtonWidget: onGetBackIcon(),
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => controller.currentType.value == 1
                    ? onGetParcelCollectionMethodLayout()
                    : onGetExpressSenderDetails()),
                Obx(() => controller.currentType.value == 1
                    ? onGetParcelPickupMethodLayout()
                    : onGetExpressReceipientDetails()),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      scaffoldKey: scaffoldKey,
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return CreateOrderTemplateWeb(
      formKey: formKey,
      screen: screen,
      isBackButtonVisible: true,
      currentTab: 1,
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              child: Column(
                children: [
                  Obx(() => controller.currentType.value == 1
                      ? onGetParcelCollectionMethodLayout()
                      : onGetExpressSenderDetails()),
                  Obx(() => controller.currentType.value == 1
                      ? onGetParcelPickupMethodLayout()
                      : onGetExpressReceipientDetails()),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MOBILE
  onGetBackIcon() {
    return InkWell(
      onTap: () {
        // Logger.dev("@71 Close Button Called");
        controller.currentTab.value = 1;
        Get.back();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.backIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  //bottom bar
  onGetBottomBar() {
    return Obx(
      () => Container(
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
              buttonText: LocaleKeys.next.tr,
              width: Get.width,
              backgroundColor: onCheckValidation()
                  ? AppColors.primaryColor
                  : AppColors.disableColor,
              isBorder: false,
              textColor: onCheckValidation()
                  ? AppColors.whiteColor
                  : AppColors.stateDisableColor,
              onTap: () {
                if (onCheckValidation()) {
                  controller.getCheckOut();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => CommonButton(
                buttonText: LocaleKeys.reset.tr,
                width: Get.width,
                backgroundColor: AppColors.whiteColor,
                isBorder: false,
                textColor: onCheckValidation()
                    ? AppColors.primaryColor
                    : AppColors.stateDisableColor,
                onTap: () {
                  if (onCheckValidation()) {
                    controller.resetAddressView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Standard flow
  //Parcel Collection Method
  onGetParcelCollectionMethodLayout() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: AppColors.whiteColor,
      ),
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: screen.isDesktop ? 0 : 10,
        right: screen.isDesktop ? 0 : 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.parcelCollectionMethod.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 10,
          ),
          onGetRadioLayout(LocaleKeys.collectFromDoorByCourier.tr, 1),
          const SizedBox(
            height: 15,
          ),
          onGetRadioLayout(LocaleKeys.dropOffAtPickupPoint.tr, 2),
          Obx(() => controller.currentTypeSender.value == 1
              ? onGetDoorSenderDetails()
              : const Offstage()),
          Obx(() => controller.currentTypeSender.value == 2
              ? onGetPickUpSenderDetails()
              : const Offstage())
        ],
      ),
    );
  }

  //index 1
  onGetDoorSenderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.senderDetails.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(flex: 2, child: onGetSelectSenderTextFormField()),
            const SizedBox(
              width: 7,
            ),
            CommonButton(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                textColor: AppColors.whiteColor,
                buttonText: LocaleKeys.addNew.tr,
                isBorder: false,
                onTap: () {
                  controller.isCreateShipment.value = true;
                  controller.isAddNewSender.value = true;
                  Get.toNamed(RouteName.senderInfoPage);
                })
          ],
        ),
        Obx(() => controller.isSelectSenderFilled.value
            ? onGetDoorDetailView(
          "+${controller.senderAddressData?.regionCode} ${controller.senderAddressData?.contactPhone}",
          "${controller.senderAddressData?.room} ${controller.senderAddressData?.floor} ${controller.senderAddressData?.address}",
                LocaleKeys.editSenderInformation.tr,
                onTap: () {
                  controller.isCreateShipment.value = false;
                  controller.isAddNewSender.value = true;
                  Get.toNamed(RouteName.senderInfoPage);
                },
              )
            : const Offstage()),
      ],
    );
  }

  onGetSelectSenderTextFormField() {
    return DropdownFormField<Addresses?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.selectSenderController.value,
      decoration:
          AppThemeState().commonDropDownDecoration(LocaleKeys.selectSender.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.isSelectSenderFilled.value = true;
          controller.senderAddressData = str;
          print("controller.senderRecipientData---${controller.senderAddressData?.address}");
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          // item != null ? item['name'] : '',
          Text(
            item != null ? item?.contactName : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.addressData,
      filterFn: (dynamic item, str) =>
          item,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item?.contactName,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.room +" "+ item?.floor +" "+ item?.address,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  //index 2
  onGetPickUpSenderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.senderDetails.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        onGetSenderNameTextField(),
        const SizedBox(
          height: 17,
        ),
        Row(
          children: [
            Flexible(flex: 1, child: onGetSenderNumberTextField()),
            const SizedBox(
              width: 7,
            ),
            Flexible(flex: 2, child: onGetSenderPhoneNumberTextField()),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.pickupPoints.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(flex: 2, child: onGetSenderAddressTextFormField()),
            const SizedBox(
              width: 7,
            ),
            CommonButton(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 38),
                textColor: AppColors.whiteColor,
                buttonText: LocaleKeys.filter.tr,
                isBorder: false,
                onTap: () {
                  Get.dialog(onGetFilterRegionView());
                })
          ],
        ),
        Obx(() => controller.isSelectSenderAddressFilled.value
            ? onGetPickupDetailView(controller.senderData)
            : const Offstage()),
      ],
    );
  }

  onGetSenderNameTextField() {
    return CustomTextFormField(
        editController: controller.senderNameController,
        focusNode: controller.focusSenderName,
        textInputAction: TextInputAction.next,
        labelText: LocaleKeys.senderName.tr,
        onChange: (value) {
          controller.senderName = value ?? "";
          print("value : -----${controller.senderName}");

        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetSenderNumberTextField() {
    return CustomTextFormField(
        editController: controller.senderNumberController,
        focusNode: controller.focusSenderNumber,
        labelText: LocaleKeys.number.tr,
        textInputType: TextInputType.number,
        onChange: (value) {
          controller.senderNumber = value ?? "";
          print("value : -----${controller.senderNumber}");

        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetSenderPhoneNumberTextField() {
    return CustomTextFormField(
        editController: controller.senderMobileNumberController,
        focusNode: controller.focusSenderMobileNumber,
        labelText: LocaleKeys.phoneNumber.tr,
        textInputType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        onChange: (value) {
          controller.senderMobileNumber = value ?? "";
          print("value : -----${controller.senderMobileNumber}");

        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetSenderAddressTextFormField() {
    return DropdownFormField<CollectionPickUpStore?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.senderAddressController.value,
      decoration:
          AppThemeState().commonDropDownDecoration(LocaleKeys.addressNo.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['address']}");
        print(str?.address);
        print(controller.senderData?.address);
        if (str != null) {
          controller.senderData = str;
          controller.isSelectSenderAddressFilled.value = true;
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          Flexible(
              child: Text(
                item != null
                    ? "${item?.districtInfo?.area?.en ?? ""} ${item?.districtInfo?.district?.en ?? ""} ${item?.address ?? ""}"
                    : '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              )),
        ],
      ),
      findFn: (dynamic str) async => controller.standardCollectionSenderAddress,
      filterFn: (dynamic item, str) {
        return item;
      },
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          "${item?.districtInfo?.area?.en ?? ""} ${item?.districtInfo?.district?.en ?? ""}",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.address ?? "",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  //Parcel pickup method
  onGetParcelPickupMethodLayout() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: screen.isDesktop ? 0 : 10,
        right: screen.isDesktop ? 0 : 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.parcelPickupMethod.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 10,
          ),
          onGetRadioLayout(LocaleKeys.deliveryToDoor.tr, 1),
          const SizedBox(
            height: 15,
          ),
          onGetRadioLayout(LocaleKeys.pickupAtPickupPoint.tr, 2),
          Obx(() => controller.currentTypeSender.value == 1
              ? onGetReceipientDetails()
              : const Offstage()),
          Obx(() => controller.currentTypeSender.value == 2
              ? onGetPickUpReceipientDetails()
              : const Offstage())
        ],
      ),
    );
  }

  //index 1
  onGetReceipientDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.receipientDetails.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(flex: 2, child: onGetReceipientDetailsTextFormField()),
            const SizedBox(
              width: 7,
            ),
            CommonButton(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                textColor: AppColors.whiteColor,
                buttonText: LocaleKeys.addNew.tr,
                isBorder: false,
                onTap: () {
                  controller.isCreateShipment.value = true;
                  controller.isAddNewSender.value = false;
                  Get.toNamed(RouteName.senderInfoPage);
                })
          ],
        ),
        Obx(() => controller.isSelectRecipientSelected.value
            ? onGetDoorDetailView(
          "+${controller.recipientAddressData?.regionCode} ${controller.recipientAddressData?.contactPhone}",
          "${controller.recipientAddressData?.room} ${controller.recipientAddressData?.floor} ${controller.recipientAddressData?.address}",
                LocaleKeys.editRecipientInformation.tr,
                onTap: () {
                  controller.isCreateShipment.value = false;
                  controller.isAddNewSender.value = false;
                  Get.toNamed(RouteName.senderInfoPage);
                },
              )
            : const Offstage()),
      ],
    );
  }

  onGetReceipientDetailsTextFormField() {
    return DropdownFormField<Addresses?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.selectRecipientController.value,
      decoration: AppThemeState()
          .commonDropDownDecoration(LocaleKeys.selectRecipient.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.isSelectRecipientSelected.value = true;
          controller.recipientAddressData = str;
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          Text(
            item != null ? item?.contactName : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.addressData,
      filterFn: (dynamic item, str) =>
          item,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item?.contactName,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.room +" "+ item?.floor +" "+ item?.address,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  //index 2
  onGetPickUpReceipientDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.recipientDetails.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        onGetRecipientNameTextField(),
        const SizedBox(
          height: 17,
        ),
        Row(
          children: [
            Flexible(flex: 1, child: onGetCountryCodeTextField()),
            const SizedBox(
              width: 7,
            ),
            Flexible(flex: 2, child: onGetRecipientPhoneNumberTextField()),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          LocaleKeys.pickPoints.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(flex: 2, child: onGetRecipientAddressTextFormField()),
            const SizedBox(
              width: 7,
            ),
            CommonButton(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 38),
                textColor: AppColors.whiteColor,
                buttonText: LocaleKeys.filter.tr,
                isBorder: false,
                onTap: () {
                  Get.dialog(onGetFilterRegionView());
                })
          ],
        ),
        Obx(() => controller.isSelectRecipientAddressSelected.value
            ? onGetPickupDetailView(controller.recipientData)
            : const Offstage()),
      ],
    );
  }

  onGetRecipientNameTextField() {
    return CustomTextFormField(
        editController: controller.recipientNameController,
        focusNode: controller.focusRecipientName,
        labelText: LocaleKeys.recipientName.tr,
        onChange: (value) {
          controller.recipientName = value ?? "";
          print("value : -----${controller.recipientName}");
        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetCountryCodeTextField() {
    return CustomTextFormField(
        editController: controller.recipientCountryCodeController,
        focusNode: controller.focusRecipientCountryCode,
        labelText: LocaleKeys.countryCode.tr,
        textInputType: TextInputType.number,
        onChange: (value) {
          controller.recipientNumber = value ?? "";
          print("value : -----${controller.recipientNumber}");
        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetRecipientPhoneNumberTextField() {
    return CustomTextFormField(
        editController: controller.recipientMobileNumberController,
        focusNode: controller.focusRecipientMobileNumber,
        labelText: LocaleKeys.phoneNumber.tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.phone,
        onChange: (value) {
          controller.recipientMobileNumber = value ?? "";
          print("value : -----${controller.recipientMobileNumber}");
        },
        onValidate: (value) {
          return Validator.emptyValidator(value);
        });
  }

  onGetRecipientAddressTextFormField() {
    return DropdownFormField<CollectionPickUpStore?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.recipientAddressController.value,
      decoration:
          AppThemeState().commonDropDownDecoration(LocaleKeys.addressNo.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.recipientData = str;
          controller.isSelectRecipientAddressSelected.value = true;
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          // item != null ? item['name'] : '',
          Flexible(
              child: Text(
                item != null
                    ? "${item?.districtInfo?.area?.en ?? ""} ${item?.districtInfo?.district?.en ?? ""} ${item?.address ?? ""}"
                    : '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              )),
        ],
      ),
      findFn: (dynamic str) async => controller.standardDeliveryRecipientAddress,
      filterFn: (dynamic item, str) {
        return item;
      },
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          "${item?.districtInfo?.area?.en ?? ""} ${item?.districtInfo?.district?.en ?? ""}",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.address ?? "",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  //common radio
  onGetRadioLayout(title, index) {
    return Obx(
      () => controller.currentTypeSender.value == index
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
                mainAxisSize: MainAxisSize.min,
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
                  ).paddingOnly(bottom: 3),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentTypeSender.value = index;
                controller.isSelectSenderFilled.value = false;
                controller.isSelectRecipientSelected.value = false;
                controller.isSelectSenderAddressFilled.value = false;
                controller.isSelectRecipientAddressSelected.value = false;
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
                    ).paddingOnly(bottom: 3),
                  ],
                ),
              ),
            ),
    );
  }

  // Common door detail view
  onGetDoorDetailView(phoneNo, address, editInfo, {required Function() onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 7,
        ),
        Text(
          phoneNo,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        Text(
          address,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        /*const SizedBox(
          height: 3,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            editInfo,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),*/
      ],
    );
  }

  // Common pickup detail view
  onGetPickupDetailView(CollectionPickUpStore? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 7,
        ),
        Text(
          "${data?.districtInfo?.area?.en} ${data?.districtInfo?.district?.en}",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        Text(
          data?.address ?? "",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '營業時間',
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        Row(
          children: [
            Text(
              // '星期一﹕${data?.mondayFrom}-${data?.mondayTo}',

              "星期一﹕${controller.timeFormat(data?.mondayFrom)} - ${controller.timeFormat(data?.mondayTo)}",
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              width: 60,
            ),
            Text(
              "星期六﹕${controller.timeFormat(data?.saturdayFrom)} - ${controller.timeFormat(data?.saturdayTo)}",
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '星期一﹕${controller.timeFormat(data?.tuesdayFrom)} - ${controller.timeFormat(data?.tuesdayTo)}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              width: 60,
            ),
            Text(
              '星期日﹕${controller.timeFormat(data?.sundayFrom)} - ${controller.timeFormat(data?.sundayTo)}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '星期一﹕${controller.timeFormat(data?.wednesdayFrom)} - ${controller.timeFormat(data?.wednesdayTo)}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              width: 60,
            ),
            Text(
              '公眾假期﹕${controller.timeFormat(data?.publicHolidayFrom)} - ${controller.timeFormat(data?.publicHolidayTo)}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '星期一﹕${controller.timeFormat(data?.thursdayFrom)} - ${controller.timeFormat(data?.thursdayTo)}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              width: 60,
            ),
            Text(
              '免費存放日數﹕${data?.freeStorage}',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        Text(
          '星期一﹕${controller.timeFormat(data?.tuesdayFrom)} - ${controller.timeFormat(data?.tuesdayTo)}',
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ],
    );
  }

  /// Express flow

  //sender
  onGetExpressSenderDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: AppColors.whiteColor,
      ),
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.senderDetails.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(flex: 2, child: onGetExpressSelectSenderTextFormField()),
              const SizedBox(
                width: 7,
              ),
              CommonButton(
                  height: 47,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  textColor: AppColors.whiteColor,
                  buttonText: LocaleKeys.addNew.tr,
                  isBorder: false,
                  onTap: () {
                    controller.isCreateShipment.value = true;
                    controller.isAddNewSender.value = true;
                    Get.toNamed(RouteName.senderInfoPage);
                  })
            ],
          ),
          Obx(() => controller.isExpressSenderFilled.value
              ? onGetDoorDetailView(
            "+${controller.senderAddressData?.regionCode} ${controller.senderAddressData?.contactPhone}",
            "${controller.senderAddressData?.room} ${controller.senderAddressData?.floor} ${controller.senderAddressData?.address}",
                  LocaleKeys.editSenderInformation.tr,
                  onTap: () {
                    controller.isCreateShipment.value = false;
                    controller.isAddNewSender.value = true;
                    Get.toNamed(RouteName.senderInfoPage);
                  },
                )
              : const Offstage()),
        ],
      ),
    );
  }

  onGetExpressSelectSenderTextFormField() {
    return DropdownFormField<Addresses?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.selectExpressSenderController.value,
      decoration:
          AppThemeState().commonDropDownDecoration(LocaleKeys.selectSender.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.isExpressSenderFilled.value = true;
          controller.senderAddressData = str;
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          // item != null ? item['name'] : '',
          Text(
            item != null ? item?.contactName : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.addressData,
      filterFn: (dynamic item, str) =>
          item,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item?.contactName,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.room +" "+ item?.floor +" "+ item?.address,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

//  Receipient

  onGetExpressReceipientDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: AppColors.whiteColor,
      ),
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.receipientDetails.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                  flex: 2, child: onGetExpressSelectReceipientTextFormField()),
              const SizedBox(
                width: 7,
              ),
              CommonButton(
                  height: 47,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  textColor: AppColors.whiteColor,
                  buttonText: LocaleKeys.addNew.tr,
                  isBorder: false,
                  onTap: () {
                    controller.isCreateShipment.value = true;
                    controller.isAddNewSender.value = false;
                    Get.toNamed(RouteName.senderInfoPage);
                  })
            ],
          ),
          Obx(() => controller.isExpressReceipientFilled.value
              ? onGetDoorDetailView(
            "+${controller.recipientAddressData?.regionCode} ${controller.recipientAddressData?.contactPhone}",
            "${controller.recipientAddressData?.room} ${controller.recipientAddressData?.floor} ${controller.recipientAddressData?.address}",
                  LocaleKeys.editRecipientInformation.tr,
                  onTap: () {
                    controller.isCreateShipment.value = false;
                    controller.isAddNewSender.value = false;
                    Get.toNamed(RouteName.senderInfoPage);
                  },
                )
              : const Offstage()),
        ],
      ),
    );
  }

  onGetExpressSelectReceipientTextFormField() {
    return DropdownFormField<Addresses?>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.selectExpressReceipientController.value,
      decoration: AppThemeState()
          .commonDropDownDecoration(LocaleKeys.selectRecipient.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.recipientAddressData = null;
          controller.isExpressReceipientFilled.value = true;
          controller.recipientAddressData = str;
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          // item != null ? item['name'] : '',
          Text(
            item != null ? item?.contactName : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.addressData,
      filterFn: (dynamic item, str) =>
          item,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item?.contactName,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        subtitle: Text(
          item?.room +" "+ item?.floor +" "+ item?.address,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  //filter
  onGetFilterRegionView() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Container(
          height: 555,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onGetFilterReset(),
              AppThemeState().commonDivider(),
              onGetFilterSearchView(),
              Flexible(
                flex: 1,
                child: onGetAddressList(),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Center(
                  child: Text(
                    LocaleKeys.back.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ).paddingSymmetric(vertical: 10),
                ),
              ),
              const SizedBox(
                height: 7,
              )
            ],
          ),
        ),
      ),
    );
  }

  onGetFilterReset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: SvgPicture.asset(
            SVGPath.closeIcon,
            width: 12,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.back();
          },
        ),
        Text(
          LocaleKeys.filterByRegion.tr,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const Offstage()
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 15);
  }

  onGetFilterSearchView() {
    return Container(
      color: AppColors.whiteColor,
      width: Get.width,
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.filterController,
              focusNode: controller.focusFilter,
              enabled: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.isEmpty) {
                  print("value ===>>> $value");
                } else {
                  controller.filterList.value.clear();
                  controller.filterListShow.forEach((item) {
                    if (item?.district?.en?.contains(value) != null) {
                      List<String> dummy = [];
                      dummy.addAll(controller.filterList.value);
                      dummy.add(item?.district?.en ?? "");
                      controller.filterList.value = dummy;
                    }
                  });
                }
              },
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.searchRegion.tr,
                hintStyle: _appTheme.customTextStyle(
                    fontSize: 15,
                    fontFamilyType: FFT.nunito,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular),
                filled: true,
                fillColor: AppColors.whiteColor,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onGetAddressList() {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.filterListShow.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                controller.selectAddress.value = controller.filterListShow[index]?.district?.en ?? "";
                print("selectAddress---------- ${controller.selectAddress.value}");
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                color: index == 0
                    ? AppColors.primaryLightColor
                    : AppColors.whiteColor,
                child: Text(
                  "${controller.filterListShow[index]?.district?.zh ?? ""} ${controller.filterListShow[index]?.district?.en ?? ""}",
                  style: _appTheme.customTextStyle(
                      fontSize: 15,
                      color: AppColors.blackColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ),
            );
          }),
    );
  }

  onCheckValidation() {
    return ((controller.isSelectSenderFilled.value &&
            controller.isSelectRecipientSelected.value) ||
        (controller.isSelectSenderAddressFilled.value &&
            controller.isSelectRecipientAddressSelected.value) ||
        (controller.isExpressSenderFilled.value &&
            controller.isExpressReceipientFilled.value));
  }
}
