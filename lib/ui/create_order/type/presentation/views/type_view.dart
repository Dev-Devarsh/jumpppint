import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/model/find_date.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../../routes.dart';
import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../widgets/common_button.dart';
import '../../../common/create_order_template.dart';
import '../../../common/create_order_template_web.dart';
import '../controllers/type_controller.dart';

class TypeView extends GetResponsiveView<TypeController> {
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
      scaffoldKey: scaffoldKey,
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
                onGetMainLayout(),
                onGetNotes(),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
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
    return CreateOrderTemplateWeb(
      formKey: formKey,
      screen: screen,
      currentTab: 1,
      isBackButtonVisible: false,
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: Get.width/5),
              child: Column(
                children: [
                  onGetMainLayout(),
                  onGetNotes(),
                  const SizedBox(
                    height: 15,
                  )
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
        scaffoldKey.currentState!.openDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SvgPicture.asset(
          SVGPath.drawerIcon,
          width: 25,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  onGetMainLayout() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: screen.isDesktop? 0 : 10,
        right: screen.isDesktop? 0 : 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          screen.isDesktop
              ? onGetStandardLayoutWeb("Standard (Earliest Arrvl: 2022-04-27)",
                  "L+W+H less than 130cm\nWeight less than 50kg\nActual Charges depends on weight or dimension weight")
              : onGetStandardLayout("Standard (Earliest Arrvl: 2022-04-27)",
                  "L+W+H less than 130cm\nWeight less than 50kg\nActual Charges depends on weight or dimension weight"),
          const SizedBox(
            height: 15,
          ),
          screen.isDesktop
              ? onGetExpressLayoutWeb("Express* (Earliest Arrvl: 2022-04-24)",
                  "\$68 for first three parcels\nForth parcels and onwards depends on weight or dimension weight")
              : onGetExpressLayout("Express* (Earliest Arrvl: 2022-04-24)",
                  "\$68 for first three parcels\nForth parcels and onwards depends on weight or dimension weight"),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => controller.currentType.value == 2
                ? onGetExpressDetailsLayout()
                : const Offstage(),
          )
        ],
      ),
    );
  }

  onGetStandardLayout(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 1
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SvgPicture.asset(
                      SVGPath.radioSelectedIcon,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: Get.width - 120,
                        child: Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 1;
                controller.getItemOption();
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        SVGPath.radioUnSelectedIcon,
                        color: AppColors.textPrimaryColor,
                      ),
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

  onGetExpressLayout(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 2
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SvgPicture.asset(
                      SVGPath.radioSelectedIcon,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: Get.width - 120,
                        child: Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 2;
                controller.getItemOption();
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        SVGPath.radioUnSelectedIcon,
                        color: AppColors.textPrimaryColor,
                      ),
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
            ?  EdgeInsets.symmetric(vertical: 10, horizontal: Get.width/5)
            : const EdgeInsets.all(10),
        child: Column(
          children: [
            CommonButton(
              padding: EdgeInsets.all(0),
              buttonText: LocaleKeys.next.tr,
              width: Get.width,
              backgroundColor: onCheckCondition()
                  ? AppColors.primaryColor
                  : AppColors.disableColor,
              isBorder: false,
              textColor: onCheckCondition()
                  ? AppColors.whiteColor
                  : AppColors.stateDisableColor,
              onTap: () {
                if (onCheckCondition()) {
                  controller.currentTab.value = 1;
                  Get.toNamed(RouteName.coParcelsPage);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => CommonButton(
                padding: EdgeInsets.all(0),
                buttonText: LocaleKeys.reset.tr,
                width: Get.width,
                backgroundColor: AppColors.whiteColor,
                isBorder: false,
                textColor: onCheckCondition()
                    ? AppColors.primaryColor
                    : AppColors.stateDisableColor,
                onTap: () {
                  if (onCheckCondition()) {
                    controller.resetTypeView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onGetNotes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*",
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            width: 5,
          ),
          screen.isDesktop
              ? Text(
                  "Applicable to fresh/ frozen/ bulky items\nL+W+H less than 120cm\nWeight less than 50kg\nActual Charges depends on weight or dimension weight",
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                )
              : SizedBox(
                  width: Get.width - 50,
                  child: Text(
                    "Applicable to fresh/ frozen/ bulky items\nL+W+H less than 120cm\nWeight less than 50kg\nActual Charges depends on weight or dimension weight",
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
        ],
      ),
    );
  }

  onGetExpressDetailsLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          LocaleKeys.expressDeliveryAndDate.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 10,
        ),
        onGetExpressDeliveryDateTextFormField(),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
          width: Get.width - 50,
          child: Text(
            "* Earliest tomorrow\n* Not applicable to Sunday and Public Holiday",
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        onGetParcelPickUpDateTextFormField(),
      ],
    );
  }

  onGetExpressDeliveryDateTextFormField() {
    return DropdownFormField<dynamic>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: LocaleKeys.noMatchFound.tr,
      controller: controller.expressDeliveryDateController.value,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        errorMaxLines: 3,
        errorStyle: AppThemeState().customTextStyle(
            fontSize: 12,
            fontFamilyType: FFT.nunito,
            color: AppColors.primaryColor,
            fontWeightType: FWT.regular),
        labelText: LocaleKeys.expressDeliveryDate.tr,
        labelStyle: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 17),
          child: SvgPicture.asset(
            SVGPath.dateIcon,
            width: 16,
            color: AppColors.textSecondaryColor,
          ),
        ),
        filled: true,
        fillColor: AppColors.backgroundColor,
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
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        // Logger.dev("@604 ${str['name']}");
        if (str != null) {
          controller.isExpressFilled.value = true;
          controller.selectSenderDate.value = str;
          print("selectSenderDate------${controller.selectSenderDate.value}");
        }
      },
      validator: (dynamic str) {
        return 'Relationship is required';
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          Text(
            item != null ? item! : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.deliveryDates,
      filterFn: (dynamic item, str) {
        return item;
      },
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item??"",
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
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

  onGetParcelPickUpDateTextFormField() {
    return DropdownFormField<PickUpDates?>(
      controller: controller.parcelPickupDateController.value,
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        errorMaxLines: 3,
        errorStyle: AppThemeState().customTextStyle(
            fontSize: 12,
            fontFamilyType: FFT.nunito,
            color: AppColors.primaryColor,
            fontWeightType: FWT.regular),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 17),
          child: SvgPicture.asset(
            SVGPath.dateIcon,
            width: 16,
            color: AppColors.textSecondaryColor,
          ),
        ),
        labelText: LocaleKeys.parcelPickupDate.tr,
        labelStyle: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
        filled: true,
        fillColor: AppColors.backgroundColor,
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
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        if (str != null) {
          controller.isPickupDateSelected.value = true;
          controller.selectRecipientDate.value = str?.date;
          print("selectRecipientDate------${controller.selectRecipientDate.value}");
        }
      },
      validator: (dynamic str) {
        return str as String;
      },
      displayItemFn: (dynamic item) => Row(
        children: [
          Text(
            item != null ? item?.date : '',
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
      findFn: (dynamic str) async => controller.pickUpDates,
      filterFn: (dynamic item, str) {
        return item;
      },
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) {
        return ListTile(
          title: Text(
            item?.date??"",
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          tileColor: focused
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.whiteColor,
          onTap: onTap,
        );
      },
    );
  }

  // WEB

  onGetStandardLayoutWeb(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 1
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SvgPicture.asset(
                      SVGPath.radioSelectedIcon,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 1;
                controller.getItemOption();
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        SVGPath.radioUnSelectedIcon,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: _appTheme.customTextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimaryColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            notes,
                            style: _appTheme.customTextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondaryColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  onGetExpressLayoutWeb(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 2
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SvgPicture.asset(
                      SVGPath.radioSelectedIcon,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 2;
                controller.getItemOption();
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        SVGPath.radioUnSelectedIcon,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: _appTheme.customTextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimaryColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            notes,
                            style: _appTheme.customTextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondaryColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  onCheckCondition() {
    return ((controller.isExpressFilled.value &&
            controller.isPickupDateSelected.value) ||
        controller.currentType.value == 1);
  }
}
