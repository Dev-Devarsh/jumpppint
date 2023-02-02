import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';

import '../../../../../../utills/app_theme.dart';
import '../../../../../../utills/asset_images.dart';
import '../../../../../../utills/colors.dart';
import '../../../../../../utills/enum/font_type.dart';
import '../../../../../../utills/generated/locales.g.dart';
import '../../../../../../utills/utils.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../common/template.dart';
import '../../../../type/presentation/controllers/type_controller.dart';

class SearchAddressView extends GetResponsiveView<TypeController> {
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
    return Template(
        padding: const EdgeInsets.all(0),
        key: scaffoldKey,
        alignment: AlignmentDirectional.topCenter,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 106),
          child: Column(
            children: [
              CommonAppBar(
                title: LocaleKeys.buildingOrStreet.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 20,
                centerTitle: true,
              ),
              onGetSearchView(false),
            ],
          ),
        ),
        body: Column(
          children: [
            Form(
              key: formKey,
              child: Obx(
                () => Column(
                  children: [
                    onGetOrderList(false),
                    controller.existingAddressList.isNotEmpty
                        ? Container()
                        : onGetText(false),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return Obx(() => TemplateWeb(
        padding: const EdgeInsets.all(0),
        key: scaffoldKey,
        alignment: AlignmentDirectional.topCenter,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                color: AppColors.primaryColor,
                child: CommonAppBar(
                  title: LocaleKeys.buildingOrStreet.tr,
                  elevation: 0.0,
                  isBackButtonVisible: true,
                  leadingWidth: 20,
                  centerTitle: true,
                ),
              ),
              onGetSearchView(true),
              Flexible(
                  fit: FlexFit.tight,
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          onGetWebOrderList(true),
                          controller.existingAddressList.isNotEmpty
                              ? Container()
                              : onGetText(true),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        )));
  }

  onGetSearchView(bool isWeb) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
          horizontal: screen.isDesktop ? Get.width / 5 : 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.enterAddressCon,
              focusNode: controller.focusEnterAddress,
              enabled: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                controller.searchAddress.value = value;
                if (value.isEmpty) {
                  controller.isSearch.value = true;
                } else {
                  controller.isSearch.value = false;
                }
                controller.getShipmentAddressSearch(controller.searchAddress.value);
              },
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.enterAddress.tr,
                hintStyle: _appTheme.customTextStyle(
                    fontSize: 14,
                    fontFamilyType: FFT.nunito,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          Obx(() => !controller.isSearch.value
              ? InkWell(
                  child: SvgPicture.asset(
                    SVGPath.closeIcon,
                    width: 11,
                    color: AppColors.secondaryColor,
                  ).marginOnly(left: 10, right: 10),
                  onTap: () {
                    controller.enterAddressCon.clear();
                    controller.existingAddressList.clear();
                    Utils.hideKeyboard();
                  },
                )
              : Offstage())
        ],
      ),
    );
  }

  onGetOrderList(bool isWeb) {
    return Container(
        width: isWeb ? Get.width / 2.8 : double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemCount: controller.existingAddressList.length,
                itemBuilder: (context, index) {
                  // if (index == controller.existingAddressList.length-1) {
                  //   return Text("use:${controller.enterAddressCon.text}");
                  // } else {
                  return InkWell(
                    onTap: () {
                      if (controller.isFromeApplyWaybills) {
                        Get.back(result: controller.existingAddressList[index]?.fullAddressEn ?? "");
                      } else {
                        controller.currentAddress.value =
                            controller.existingAddressList[index]?.fullAddressEn ?? "";
                        controller.buildingOrStreetNoCon.text =
                            controller.currentAddress.value;
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 13, bottom: 10),
                      color: index % 2 != 0
                          ? AppColors.listOddColor
                          : AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          controller.existingAddressList[index]?.fullAddressEn ?? "",
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ),
                  );
                  // }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: InkWell(
                onTap: () {
                  if (controller.isFromeApplyWaybills) {
                    Get.back(result: controller.enterAddressCon.text);
                  } else {
                    controller.currentAddress.value =
                        controller.enterAddressCon.text;
                    controller.buildingOrStreetNoCon.text =
                        controller.enterAddressCon.text;
                    Get.back();
                  }
                },
                child: Text("Use: ${controller.enterAddressCon.text}",
                    style: _appTheme.customTextStyle(
                        fontSize: 15,
                        color: AppColors.blackColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito)),
              ),
            )
          ],
        ));
  }

  onGetWebOrderList(bool isWeb) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: screen.isDesktop ? Get.width / 5 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.existingAddressList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (controller.isFromeApplyWaybills) {
                        Get.back(result: controller.existingAddressList[index]?.fullAddressEn ?? "");
                      } else {
                        controller.currentAddress.value =
                            controller.existingAddressList[index]?.fullAddressEn ?? "";
                        controller.buildingOrStreetNoCon.text =
                            controller.currentAddress.value;
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 13, bottom: 10),
                      color: index % 2 != 0
                          ? AppColors.listOddColor
                          : AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Text(
                          controller.existingAddressList[index]?.fullAddressEn ?? "",
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: InkWell(
                onTap: () {
                  if (controller.isFromeApplyWaybills) {
                    Get.back(result: controller.enterAddressCon.text);
                  } else {
                    controller.currentAddress.value =
                        controller.enterAddressCon.text;
                    controller.buildingOrStreetNoCon.text =
                        controller.enterAddressCon.text;
                    Get.back();
                  }
                },
                child: Text("Use: ${controller.enterAddressCon.text}",
                    style: _appTheme.customTextStyle(
                        fontSize: 15,
                        color: AppColors.blackColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito)),
              ),
            )
          ],
        ));
  }

  onGetText(bool isWeb) {
    return Container(
        width: isWeb ? Get.width / 2.8 : double.infinity,
        child: Text(
          LocaleKeys.noAddressMatched.tr,
          style: _appTheme.customTextStyle(
              fontSize: 14,
              fontFamilyType: FFT.nunito,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular),
          textAlign: TextAlign.center,
        ).paddingOnly(top: 5));
  }
}
