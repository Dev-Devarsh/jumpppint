import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/controllers/type_controller.dart';

import '../../../routes.dart';
import '../../../utills/app_theme.dart';
import '../../../utills/asset_images.dart';
import '../../../utills/colors.dart';
import '../../../utills/enum/font_type.dart';
import '../../../utills/generated/locales.g.dart';
import '../../common/template_web.dart';

class CreateOrderTemplateWeb extends StatefulWidget {
    CreateOrderTemplateWeb(
      {Key? key,
      required this.formKey,
      this.body,
      this.bottomBar,
      this.autovalidate = AutovalidateMode.onUserInteraction,
      required this.screen,
      required this.currentTab,
      this.isBackButtonVisible})
      : super(key: key);

  final Widget? body;
  final Widget? bottomBar;
  final GlobalKey<FormState> formKey;
  final ResponsiveScreen screen;
  final int currentTab;
  final bool? isBackButtonVisible;
    AutovalidateMode? autovalidate;

  @override
  State<CreateOrderTemplateWeb> createState() => _CreateOrderTemplateWebState();
}

class _CreateOrderTemplateWebState extends State<CreateOrderTemplateWeb> {
  TypeController controller = Get.find<TypeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentTab.value == 3) {
          controller.currentTab.value = 2;
          Get.back();
        } else if (controller.currentTab.value == 2) {
          controller.currentTab.value = 1;
          Get.back();
        } else if (controller.currentTab.value == 1) {
          controller.currentTab.value = 0;
          Get.back();
        } else if (controller.currentTab.value == 0) {
          Get.offNamed(RouteName.homePage);
        }
        return false;
      },
      child: TemplateWeb(
        currentTab: widget.currentTab,
        body: Center(
          child: Container(
              color: AppColors.backgroundColor,
              child: Form(
                key: widget.formKey,
                autovalidateMode:widget.autovalidate!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 50,
                      color: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (widget.isBackButtonVisible == true)
                            InkWell(
                              child: SvgPicture.asset(
                                SVGPath.backIcon,
                              ).paddingAll(17),
                              onTap: () {
                                if (controller.currentTab.value == 3) {
                                  controller.currentTab.value = 2;
                                  Get.back();
                                } else if (controller.currentTab.value == 2) {
                                  controller.currentTab.value = 1;
                                  Get.back();
                                } else if (controller.currentTab.value == 1) {
                                  controller.currentTab.value = 0;
                                  Get.back();
                                }
                              },
                            ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(
                              LocaleKeys.createShipment.tr,
                              textAlign: TextAlign.center,
                              style: AppThemeState().customTextStyle(
                                  fontSize: 20,
                                  color: AppColors.whiteColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onGetTopProgressTab(),
                    widget.body ?? const Offstage(),
                    widget.bottomBar ?? const Offstage(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  onGetTopProgressTab() {
    return Container(
      width: Get.width,
      padding: widget.screen.isDesktop
          ? const EdgeInsets.only(top: 20, bottom: 15, left: 0, right: 0)
          : const EdgeInsets.only(top: 20, bottom: 15, left: 5, right: 5),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [AppThemeState().commonBoxShadow()]),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            onGetWidgetHeading(LocaleKeys.type.tr, 0),
            const SizedBox(
              width: 5,
            ),
            onGetWidgetHeading(LocaleKeys.parcel.tr, 1),
            const SizedBox(
              width: 5,
            ),
            onGetWidgetHeading(LocaleKeys.addresses.tr, 2),
            const SizedBox(
              width: 5,
            ),
            onGetWidgetHeading(LocaleKeys.checkout.tr, 3),
          ],
        ),
      ),
    );
  }

  onGetWidgetHeading(String title, int menuIndex) {
    return Obx(
      () => Column(
        children: [
          SvgPicture.asset(
            SVGPath.orderStageIcon,
            width: 80,
            color: controller.currentTab.value == menuIndex
                ? AppColors.primaryColor
                : AppColors.stateDisableColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: AppThemeState().customTextStyle(
                fontSize: 12,
                color: controller.currentTab.value == menuIndex
                    ? AppColors.primaryColor
                    : AppColors.stateDisableColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }
}
