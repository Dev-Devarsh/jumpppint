import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/browsecargo/presentation/controllers/browse_cargo_controller.dart';
import 'package:jumppoint_app/ui/browsecargo/status/presentation/views/status_view.dart';
import 'package:jumppoint_app/ui/browsecargo/waybill/presentation/views/waybill_view.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../../utills/generated/locales.g.dart';

class BrowseCargoView extends GetResponsiveView<BrowseCargoController> {
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
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: title("JP123456789"),
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [onGetTabBar(false), onGetTabBarView(false)],
          ),
        ));
  }

  @override
  Widget? tablet() {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: title("JP123456789"),
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [onGetTabBar(false), onGetTabBarView(false)],
          ),
        ));
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 4,
        body:
            Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                title: title("JP123456789"),
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 27,
                centerTitle: true,
              ),
            ),
            onGetTabBar(true),
            onGetTabBarView(true)
          ],
        ));
  }

  onGetTabBar(bool isWeb) {
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: isWeb
            ? EdgeInsets.symmetric(horizontal: Get.width/5)
            : null,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [AppThemeState().commonBoxShadow()]),
        child: TabBar(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          controller: controller.tabController,
          tabs: [
            Tab(
              text: LocaleKeys.status.tr,
            ),
            Tab(
              text: LocaleKeys.waybill.tr,
            ),
          ],
        ),
      ),
    );
  }

  onGetTabBarView(bool isWeb) {
    return Flexible(
      flex: 1,
      child: TabBarView(controller: controller.tabController, children: [
        Obx(() => controller.statusLogsList.isNotEmpty ? StatusView(statusLogsList: controller.statusLogsList) : Container()),
        WayBillView(),
      ]).paddingSymmetric(horizontal: isWeb ? Get.width/5 : 10),
    );
  }

  String title(String title) {
    return "${LocaleKeys.item.tr} - $title";
  }
}
