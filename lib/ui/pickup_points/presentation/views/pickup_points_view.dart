import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/pickup_points/presentation/controllers/pickup_point_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../common/custom_drawer.dart';

class PickupPointsView extends GetResponsiveView<PickupPointsController> {
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
      backgroundColor: AppColors.statusBarColor,
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.listPickupLbl.tr,
          elevation: 0.0,
          isBackButtonVisible: false,
          leading: onGetBackIcon(),
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      drawer: Drawer(
        child: CommonDrawer(currentIndex: RxInt(7), onLogoutClick: () {
          controller.logout();
        },),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              onGetSearchView(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Obx(() => controller. isSearch.value == true
                          ? Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          LocaleKeys.noRecord.tr,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    )
                          : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.pickupPointList.length,
                          itemBuilder: (context, index) {
                            return onGetRecordItem(index);
                          }),
                    ),
                    ),
                  ),
                ),
              ),
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
      currentTab: 7,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screen.width/5),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.listPickupLbl.tr,
              elevation: 0.0,
              isBackButtonVisible: false,
              leadingWidth: 50,
              centerTitle: true,
            ),
          ),
          onGetSearchView(),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Obx(() => controller. isSearch.value == true
                    ? Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      LocaleKeys.noRecord.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal:
                      screen.isDesktop ? screen.width / 5 : 8),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.pickupPointList.length,
                      itemBuilder: (context, index) {
                        return onGetRecordItem(index);
                      }),
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onGetBackIcon() {
    return InkWell(
      onTap: () {
        scaffoldKey.currentState!.openDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.drawerIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  onGetRecordItem(int index) {
    return Material(
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color:
                index % 2 != 0 ? AppColors.listOddColor : AppColors.whiteColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.pickupPointList[index].pickupPointsNo ?? "",
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.pickupPointList[index].pickupPointsTitle ?? "",
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
                      "${controller.pickupPointList[index].pickupPointsAddress ?? ""}",
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

  onGetSearchView() {
    return Container(
      color: AppColors.appBarColor,
      padding: screen.isDesktop
          ? EdgeInsets.only(left: screen.width/5, right: screen.width/5, bottom: 10, top: 0)
          : const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.editConSearch,
              focusNode: controller.focusSearch,
              enabled: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.isEmpty) {
                  controller.isSearch.value = true;
                } else {
                  controller.isSearch.value = false;
                }
              },
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.pickupPointLbl.tr,
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 0, bottom: 7),
                hintStyle: _appTheme.customTextStyle(
                    fontSize: 14,
                    fontFamilyType: FFT.nunito,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular),
                filled: true,
                fillColor: AppColors.backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                suffixIcon: Obx(() => !controller.isSearch.value
                    ? InkWell(
                        onTap: () {
                          controller.editConSearch.clear();
                          controller.isSearch.value = true;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(SVGPath.closeIcon),
                        ),
                      )
                    : const Offstage()),
                suffixIconColor: AppColors.textSecondaryColor,
              ),
            ).marginOnly(right: 16),
          ),
        ],
      ),
    );
  }
}
