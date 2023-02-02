import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:jumppoint_app/ui/transaction_record/presentation/controllers/transaction_record_controller.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../../utills/enum/font_type.dart';
import '../../../../utills/generated/locales.g.dart';
import '../../../common/common_app_bar.dart';
import '../../../common/template_web.dart';

class TransactionRecordView extends GetResponsiveView<TransactionRecordController> {
  final AppThemeState _appTheme = AppThemeState();

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
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.transactionRecord.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 27,
          centerTitle: true,
        ),
      ),
      body: onGetOrderList(false),
    ));
  }

  @override
  Widget? tablet() {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.transactionRecord.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 27,
          centerTitle: true,
        ),
      ),
      body: onGetOrderList(false),
    ));
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 5,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 27,
                title: LocaleKeys.transactionRecord.tr,
                centerTitle: true,
              ),
            ),
            onGetOrderList(true),
          ],
        ));
  }

  onGetOrderList(bool isWeb) {
    return Obx(() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.paymentLogs.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                onCommonTextFormField(
                    LocaleKeys.transactionRecordDate
                        .trParams({'transactionRecordDate': Utils.apiDateFormatByDate(controller.paymentLogs[index]?.createdAt ?? "")}),
                    12,
                    AppColors.textSecondaryColor),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.paymentLogs.length,
                    itemBuilder: (context, index) {
                      return onGetOrderListItem(index, isWeb);
                    })
              ],
            ),
          );
        }).paddingSymmetric(horizontal: isWeb ? Get.width / 5 : 10));
  }

  onGetOrderListItem(int index, bool isWeb) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
                child: onCommonTextFormField(
                    "Express Order Created", 16, AppColors.textPrimaryColor)),
            onCommonTextFormField("HKD -28", 16,
                index == 1 ? AppColors.greenColor : AppColors.primaryColor)
          ],
        ),
      ),
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Text(
      str,
      style: AppThemeState().customTextStyle(
          fontSize: fontSize,
          color: color,
          fontWeightType: FWT.regular,
          fontFamilyType: FFT.nunito),
    );
  }
}
