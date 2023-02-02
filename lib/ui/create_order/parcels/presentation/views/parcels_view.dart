import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/create_order/common/create_order_template_web.dart';
import 'package:jumppoint_app/ui/create_order/model/parcel_item_option_model.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../../routes.dart';
import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../../../common/create_order_template.dart';
import '../../../model/parcel_model.dart';
import '../../../type/presentation/controllers/type_controller.dart';

class ParcelsView extends GetResponsiveView<TypeController> {
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
      scaffoldKey: scaffoldKey,
      screen: screen,
      closeButtonWidget: onGetBackIcon(),
      leadingWidth: 50,
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Obx(
                        () =>
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.parcelList.length,
                            itemBuilder: (context, index) {
                              return onGetParcelItem(index);
                            }),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.collapseAll();
                    controller.parcelList
                        .add(ParcelModel(isExpanded: RxBool(true)));
                  },
                  child: onGetAddMoreText(),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    controller.getItemPreviousParcel();
                    onGetPastRecords();
                  },
                  child: onGetPassRecordText(),
                ),
                const SizedBox(
                  height: 15,
                ),
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
      // autovalidate: AutovalidateMode.onUserInteraction,
      currentTab: 1,
      isBackButtonVisible: true,
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Obx(
                          () =>
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.parcelList.length,
                              itemBuilder: (context, index) {
                                return onGetParcelItem(index);
                              }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.collapseAll();
                      controller.parcelList
                          .add(ParcelModel(isExpanded: RxBool(true)));
                    },
                    child: onGetAddMoreText(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      onGetPastRecords();
                    },
                    child: onGetPassRecordText(),
                  ),
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
        controller.currentTab.value = 0;
        Get.back();
      },
      child: Padding(
        padding:
        const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.backIcon,
          width: 24,
          color: AppColors.whiteColor,
        ),
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
            buttonText: LocaleKeys.next.tr,
            width: Get.width,
            backgroundColor: AppColors.primaryColor,
            isBorder: false,
            textColor: AppColors.whiteColor,
            onTap: () {
              if (formKey.currentState!.validate()) {
                // controller.currentTab.value = 2;
                controller.getValidateTrackingNo(controller.trackingNo?.value);
                controller.doPickUpStoreOption();
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
              controller.resetParcelView();
            },
          ),
        ],
      ),
    );
  }

  onGetParcelItem(int index) {
    return Obx(
          () =>
      controller.parcelList[index].isExpanded.value
          ? onExpandedParcelItem(index)
          : onGetCollapseParcelItem(index),
    );
  }

  onExpandedParcelItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            controller.parcelList[index].isExpanded.value = false;
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [AppThemeState().commonBoxShadow()],
            ),
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Parcel-${index + 1}",
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    SvgPicture.asset(
                      SVGPath.expandedIcon,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                          textInputAction: TextInputAction.done,
                          editController: controller
                              .parcelList[index].trackingNoController.value,
                          focusNode:
                          controller.parcelList[index].focusTrackingNo,
                          labelText: LocaleKeys.trackingNo.tr,
                          onChange: (value) {
                            controller.trackingNo?.value = value!;
                            print("trackingNo.value${value}");
                            controller.parcelList[index].trackingNo = value;
                          },
                          onValidate: (value) {
                            return Validator.emptyValidator(value);
                          }),
                    ),
                    kIsWeb
                        ? const Offstage()
                        : const SizedBox(
                      width: 7,
                    ),
                    kIsWeb
                        ? const Offstage()
                        : CommonButton(
                      height: 47,
                      buttonText: LocaleKeys.scanCode.tr,
                      backgroundColor: AppColors.primaryColor,
                      isBorder: false,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      textColor: AppColors.whiteColor,
                      onTap: () {
                        Get.toNamed(RouteName.allowQRPermission,
                            arguments: index);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  LocaleKeys.parcelStickyNote.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
                const SizedBox(
                  height: 15,
                ),
                onGetProductNatureDropDown(index),
                const SizedBox(
                  height: 17,
                ),
                onGetDimensionDropDown(index),
                const SizedBox(
                  height: 17,
                ),
                onGetWeightDropDown(index),
                /* CustomTextFormField(
                    editController:
                        controller.parcelList[index].weightController.value,
                    focusNode: controller.parcelList[index].focusWeight,
                    labelText: LocaleKeys.weight.tr,
                    maxLength: 2,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                    onChange: (value) {},
                    onValidate: (value) {
                      return Validator.emptyValidator(value);
                    }),*/
                const SizedBox(
                  height: 17,
                ),
                onGetTempDropDown(index),
                Obx(() =>
                controller.currentType.value == 2
                    ? const SizedBox(
                  height: 17,
                )
                    : const Offstage()),
                CustomTextFormField(
                    editController:
                    controller.parcelList[index].remarkController.value,
                    focusNode: controller.parcelList[index].focusRemark,
                    labelText: LocaleKeys.remarks.tr,
                    maxLines: 5,
                    minLines: 5,
                    textInputAction: TextInputAction.done,
                    isAlignLabelWithHint: true,
                    maxLength: 70,
                    textAlign: TextAlign.start,
                    contentPadding: const EdgeInsets.only(
                        left: 15, right: 15, top: 25, bottom: 0),
                    textInputType: TextInputType.multiline,
                    onChange: (value) {
                      controller.remarkLength.value =
                      value != null ? value.length : 0;
                      controller.parcelList[index].remark = value;
                    },
                    onValidate: (value) {
                      // return Validator.emptyValidator(value);
                    }),
                const SizedBox(
                  height: 7,
                ),
                Obx(
                      () =>
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          '${controller.remarkLength}/70',
                          style: _appTheme.customTextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                ),
                index != 0
                    ? const SizedBox(
                  height: 10,
                )
                    : const Offstage(),
                index != 0
                    ? CommonButton(
                  buttonText: LocaleKeys.remove.tr,
                  width: Get.width,
                  backgroundColor:
                  AppColors.primaryColor.withOpacity(0.05),
                  isBorder: false,
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    screen.isDesktop
                        ? Utils.showCommonDialogWeb(
                        title: LocaleKeys.removeParcelMessage.tr,
                        positiveText: LocaleKeys.confirm.tr,
                        negativeText: LocaleKeys.cancel.tr,
                        isNegativeButtonShow: true,
                        onNegativeTap: () {
                          Get.back();
                        },
                        onTap: () {
                          Get.back();
                          controller.parcelList.removeAt(index);
                        })
                        : Utils.showCommonDialog(
                        title: LocaleKeys.removeParcelMessage.tr,
                        positiveText: LocaleKeys.confirm.tr,
                        negativeText: LocaleKeys.cancel.tr,
                        isNegativeButtonShow: true,
                        onNegativeTap: () {
                          Get.back();
                        },
                        onTap: () {
                          Get.back();
                          controller.parcelList.removeAt(index);
                        });
                  },
                )
                    : const Offstage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onGetCollapseParcelItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            controller.collapseAll();
            controller.parcelList[index].isExpanded.value = true;
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [AppThemeState().commonBoxShadow()],
            ),
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Parcel-${index + 1}",
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    SvgPicture.asset(
                      SVGPath.collapseIcon,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                      () =>
                      Text(
                        onGetCollapseValue(index),
                        style: _appTheme.customTextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onGetProductNatureDropDown(int index) {
    return DropdownFormField<ProductCategory?>(
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No matching found!",
        controller: controller.parcelList[index].productNatureController.value,
        decoration: AppThemeState().commonDropDownDecoration(
            controller.parcelList[index].productNature == null
                ? LocaleKeys.productNature.tr
                : '',errorText: controller.parcelList[index].productNature == null ? "This Field is required" : null),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          // Logger.dev(str['name']);
          controller.parcelList[index].productNature = str?.description?.en;
          controller.parcelList[index].productNatureId = str?.id;
          formKey.currentState!.validate();
        },
        validator: (dynamic str) {
          print("VALIDATOR CALLED 1");
          return str?.description?.en == null ? 'This Field is required' : null;
        },
        displayItemFn: (dynamic item) {
          return Text(
            item != null
                ? item?.description?.en
                : controller.parcelList[index].productNature ?? '',
            style: AppThemeState().customTextStyle(
                fontSize: 14,
                fontFamilyType: FFT.nunito,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular),
          );
        },
        findFn: (dynamic str) async => controller.category,
        filterFn: (dynamic item, str) {
          return item;
        },
        dropdownItemFn: (dynamic item, position, focused,
            dynamic lastSelectedItem, onTap) =>
            onGetDropDownItem(
                item?.description?.en,
                position,
                focused,
                lastSelectedItem,
                onTap,
                index,
                controller.parcelList[index].productNature ?? "",
                controller.parcelList[index].productNatureId ?? ""));
  }

  onGetDimensionDropDown(int index) {
    return DropdownFormField<Dimension?>(
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No matching found!",
        controller: controller.parcelList[index].dimensionController.value,
        dropdownHeight: 150,
        decoration: AppThemeState().commonDropDownDecoration(
            controller.parcelList[index].dimension == null
                ? LocaleKeys.dimension.tr
                : '',errorText: controller.parcelList[index].dimension == null ? 'This Field is required' : null),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          // Logger.dev(str['name']);
          controller.parcelList[index].dimension = str?.description?.en;
          controller.parcelList[index].dimensionId = str?.id;
        },
        validator: (dynamic str) {
           return str?.description?.en == null ? 'This Field is required' : null;
        },
        displayItemFn: (dynamic item) {
          return Text(
            item != null
                ? item?.description?.en
                : controller.parcelList[index].dimension ?? '',
            style: AppThemeState().customTextStyle(
                fontSize: 14,
                fontFamilyType: FFT.nunito,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular),
          );
        },
        findFn: (dynamic str) async => controller.dimension,
        filterFn: (dynamic item, str) {
          return item;
        },
        dropdownItemFn: (dynamic item, position, focused,
            dynamic lastSelectedItem, onTap) =>
            onGetDropDownItem(
                item?.description?.en,
                position,
                focused,
                lastSelectedItem,
                onTap,
                index,
                controller.parcelList[index].dimension ?? "",
                controller.parcelList[index].dimensionId ?? ""));
  }

  onGetWeightDropDown(int index) {
    return Obx(
          () =>
      controller.currentType.value == 2
          ? DropdownFormField<Weight?>(
          onEmptyActionPressed: () async {},
          emptyActionText: "",
          emptyText: "No matching found!",
          controller: controller.parcelList[index].weightController.value,
          dropdownHeight: 150,
          decoration: AppThemeState().commonDropDownDecoration(
              controller.parcelList[index].weight == null
                  ? LocaleKeys.weight.tr
                  : '',errorText: controller.parcelList[index].weight == null ? 'This Field is required' : null),
          onSaved: (dynamic str) {},
          onChanged: (dynamic str) {
            // Logger.dev(str['name']);
            controller.parcelList[index].weight = str?.description?.en;
            controller.parcelList[index].weightId = str?.id;
          },
          validator: (dynamic str) {
            print("VALIDATOR CALLED 3");
            return str?.description?.en == null
                ? 'This Field is required'
                : null;
          },
          displayItemFn: (dynamic item) {
            return Text(
              item != null
                  ? item?.description?.en
                  : controller.parcelList[index].weight ?? '',
              style: AppThemeState().customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
            );
          },
          findFn: (dynamic str) async => controller.weight,
          filterFn: (dynamic item, str) {
            return item;
          },
          dropdownItemFn: (dynamic item, position, focused,
              dynamic lastSelectedItem, onTap) =>
              onGetDropDownItem(
                  item?.description?.en,
                  position,
                  focused,
                  lastSelectedItem,
                  onTap,
                  index,
                  controller.parcelList[index].weight ?? "",
                  controller.parcelList[index].weightId ?? ""))
          : DropdownFormField<DimensionThirdParty?>(
          onEmptyActionPressed: () async {},
          emptyActionText: "",
          emptyText: "No matching found!",
          controller: controller.parcelList[index].weightController.value,
          dropdownHeight: 150,
          decoration: AppThemeState().commonDropDownDecoration(
              controller.parcelList[index].weight == null
                  ? LocaleKeys.weight.tr
                  : '',errorText: controller.parcelList[index].weight == null ? 'This Field is required' : null),
          onSaved: (dynamic str) {},
          onChanged: (dynamic str) {
            // Logger.dev(str['name']);
            controller.parcelList[index].weight = str?.description?.en;
            controller.parcelList[index].weightId = str?.id;
          },
          validator: (dynamic str) {
            print("VALIDATOR CALLED 4");
            return str?.description?.en == null
                ? 'This Field is required'
                : null;
          },
          displayItemFn: (dynamic item) {
            return Text(
              item != null
                  ? item?.description?.en
                  : controller.parcelList[index].weight ?? '',
              style: AppThemeState().customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
            );
          },
          findFn: (dynamic str) async => controller.dimensionThirdParty,
          filterFn: (dynamic item, str) {
            return item;
          },
          dropdownItemFn: (dynamic item, position, focused,
              dynamic lastSelectedItem, onTap) =>
              onGetDropDownItem(
                  item?.description?.en,
                  position,
                  focused,
                  lastSelectedItem,
                  onTap,
                  index,
                  controller.parcelList[index].weight ?? "",
                  controller.parcelList[index].weightId ?? "")),
    );
  }

  onGetTempDropDown(int index) {
    return Obx(
          () =>
      controller.currentType.value == 2
          ? DropdownFormField<Temperature?>(
          onEmptyActionPressed: () async {},
          emptyActionText: "",
          emptyText: "No matching found!",
          controller: controller.parcelList[index].tempController.value,
          dropdownHeight: 150,
          decoration: AppThemeState().commonDropDownDecoration(
              controller.parcelList[index].temperature == null
                  ? LocaleKeys.temperature.tr
                  : '',errorText: controller.parcelList[index].temperature == null ? 'This Field is required' : null),
          onSaved: (dynamic str) {},
          onChanged: (dynamic str) {
            // Logger.dev(str['name']);
            controller.parcelList[index].temperature = str?.description?.en;
            controller.parcelList[index].temperatureId = str?.id;
          },
          validator: (dynamic str) {
            print("VALIDATOR CALLED 4");
            return str?.description?.en == null
                ? 'This Field is required'
                : null;
          },
          displayItemFn: (dynamic item) {
            return Text(
              item != null
                  ? item?.description?.en
                  : controller.parcelList[index].temperature ?? '',
              style: AppThemeState().customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
            );
          },
          findFn: (dynamic str) async => controller.temperature,
          filterFn: (dynamic item, str) {
            return item;
          },
          dropdownItemFn: (dynamic item, position, focused,
              dynamic lastSelectedItem, onTap) =>
              onGetDropDownItem(
                  item?.description?.en,
                  position,
                  focused,
                  lastSelectedItem,
                  onTap,
                  index,
                  controller.parcelList[index].temperature ?? "",
                  controller.parcelList[index].temperatureId ?? ""
              ))
          : const Offstage(),
    );
  }

  onGetDropDownItem(dynamic item, int position, bool focused, lastSelectedItem,
      Function() onTap, int itemIndex, String name, String id) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        item,
        style: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular),
      ),
      tileColor: onGetFocusItem(focused, itemIndex, item, name)
          ? AppColors.primaryColor.withOpacity(0.1)
          : Colors.transparent,
      onTap: onTap,
    );
  }

  String onGetCollapseValue(int index) {
    String value = "";
    // Logger.dev("Test : ${presentation.parcelList[index].productNature}");
    if (controller
        .parcelList[index].trackingNoController.value.text.isNotEmpty) {
      value =
      "$value ${controller.parcelList[index].trackingNoController.value.text},";
    }
    if (controller.parcelList[index].productNature != null) {
      value = "$value ${controller.parcelList[index].productNature},";
    }
    if (controller.parcelList[index].dimension != null) {
      value = "$value ${controller.parcelList[index].dimension},";
    }
    if (controller.parcelList[index].temperature != null) {
      value = "$value ${controller.parcelList[index].temperature},";
    }
    if (controller.parcelList[index].weight != null) {
      value =
      "$value ${controller.parcelList[index].weight},";
    }
    if (controller.parcelList[index].remarkController.value.text.isNotEmpty) {
      value =
      "$value ${controller.parcelList[index].remarkController.value.text},";
    }
    return value.isEmpty
        ? "Empty Records"
        : value.substring(value.length - 1, value.length) == ","
        ? value.substring(0, value.length - 2)
        : value;
  }

  onGetFocusItem(bool focused, int itemIndex, String name, String listName) {
    if (listName != null) {
      if (listName == name) {
        return true;
      }
    } else {
      if (focused) {
        return true;
      }
    }
    return false;
  }

  void onGetPastRecords() {
    Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        // insetPadding: screen.isDesktop
        //     ? const EdgeInsets.symmetric(horizontal: 800.0)
        //     : const EdgeInsets.symmetric(horizontal: 10.0),
        content: SizedBox(
          width: screen.isDesktop ? Get.width / 5 : Get.width,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SvgPicture.asset(
                        SVGPath.closeIcon,
                        width: 18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.pastRecords.tr,
                      textAlign: TextAlign.center,
                      style: AppThemeState().customTextStyle(
                          fontSize: 14,
                          fontFamilyType: FFT.nunito,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              AppThemeState().commonDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                        () =>
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.currentType.value == 1
                                ? controller.standardPreviousItems.length
                                : controller.samedayPreviousItems.length,
                            itemBuilder: (context, index) {
                              return onGetPastRecordItem(index);
                            }),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onGetPastRecordItem(int index) {
    return Material(
      child: InkWell(
        onTap: () {
          Get.back();
          controller.collapseAll();
          controller.parcelList[index].isExpanded.value = true;
          if(controller.currentType.value == 1){
          controller.standardPastRecord.clear();
          controller.standardPastRecord.add(controller.standardPreviousItems[index]);
          print("standardPastRecord==== ${controller.standardPastRecord.length}");
          controller.parcelList[index].productNature = controller.standardPastRecord[index]?.categoryOption?.description?.en?.value;
          print("standardPastRecord==== ${controller.parcelList[index].productNature}");
          controller.parcelList[index].dimension = controller.standardPastRecord[index]?.dimensionOption?.description?.en?.value;
          print("standardPastRecord==== ${controller.parcelList[index].dimension}");
          controller.parcelList[index].weight = controller.standardPastRecord[index]?.weightOption?.description?.en?.value;
          print("standardPastRecord==== ${controller.parcelList[index].weight}");

          }else{
            controller.samedayPastRecord.clear();
            controller.samedayPastRecord.add(controller.samedayPreviousItems[index]);
            print("samedayPastRecord==== ${controller.samedayPastRecord.length}");
            controller.parcelList[index].productNature = controller.samedayPastRecord[index]?.categoryOption?.description?.en;
            print("standardPastRecord==== ${controller.parcelList[index].productNature}");
            controller.parcelList[index].dimension = controller.samedayPastRecord[index]?.dimensionOption?.description?.en;
            print("standardPastRecord==== ${controller.parcelList[index].dimension}");
            controller.parcelList[index].weight = controller.samedayPastRecord[index]?.weightOption?.description?.en;
            print("standardPastRecord==== ${controller.parcelList[index].weight}");
            controller.parcelList[index].temperature = controller.samedayPastRecord[index]?.temperatureOption?.description?.en;
            print("standardPastRecord==== ${controller.parcelList[index].temperature}");
          }
          /* var model = controller.previousItems[index];
          model.isExpanded.value = true;
          model.trackingNoController.value.text = model.trackingNo ?? "";
          // model.weightController.value.text = model.weight ?? "";
          model.remarkController.value.text = model.remark ?? "";
          controller.parcelList.add(model);*/
        },
        child: Container(
          width: Get.width,
          color: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(controller.currentType.value == 1)...[
                Text(
                  controller.standardPreviousItems[index]?.categoryOption?.description?.en?.value ?? "",
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${controller.standardPreviousItems[index]?.dimensionOption?.description?.en?.value ??
                      ""}, ${controller.standardPreviousItems[index]?.weightOption?.description?.en?.value ??
                      ""}",
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ] else...[
                Text(
                  controller.samedayPreviousItems[index]?.categoryOption?.description?.en ?? "",
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${controller.samedayPreviousItems[index]?.dimensionOption?.description?.en ??
                      ""}, ${controller.samedayPreviousItems[index]?.weightOption?.description?.en ??
                      ""}",
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  onGetAddMoreText() {
    return Text(
      LocaleKeys.addMore.tr,
      style: _appTheme.customTextStyle(
          fontSize: 12,
          color: AppColors.primaryColor,
          fontWeightType: FWT.regular,
          fontFamilyType: FFT.nunito),
    );
  }

  onGetPassRecordText() {
    return Text(
      LocaleKeys.addFromPastRecords.tr,
      style: _appTheme.customTextStyle(
          fontSize: 12,
          color: AppColors.primaryColor,
          fontWeightType: FWT.regular,
          fontFamilyType: FFT.nunito),
    );
  }
}
