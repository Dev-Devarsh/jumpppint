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
import '../../common/common_app_bar.dart';
import '../../common/custom_drawer.dart';

class CreateOrderTemplate extends StatefulWidget {
  const CreateOrderTemplate(
      {Key? key,
      this.closeButtonWidget,
      required this.formKey,
      this.body,
      this.bottomBar,
      required this.screen,
      this.leadingWidth,
      required this.scaffoldKey})
      : super(key: key);

  final double? leadingWidth;
  final Widget? closeButtonWidget;
  final Widget? body;
  final Widget? bottomBar;
  final GlobalKey<FormState> formKey;
  final ResponsiveScreen screen;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CreateOrderTemplate> createState() => _CreateOrderTemplateState();
}

class _CreateOrderTemplateState extends State<CreateOrderTemplate> {
  TypeController controller = Get.find<TypeController>();

  @override
  Widget build(BuildContext context) {
    return controller.currentTab.value == 0
        ? onGetWithDrawer()
        : onGetWithoutDrawer();
  }

  onGetWithDrawer() {
    return Scaffold(
        key: widget.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.createShipment.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: widget.closeButtonWidget ?? const Offstage(),
            leadingWidth: widget.leadingWidth ?? 27,
            centerTitle: true,
          ),
        ),
        drawer: Drawer(child: CommonDrawer(currentIndex: RxInt(1), onLogoutClick: () {
          controller.logout();
        },)),
        body: SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              color: AppColors.backgroundColor,
              width: Get.width,
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    onGetTopProgressTab(),
                    widget.body ?? const Offstage(),
                    widget.bottomBar ?? const Offstage(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  onGetWithoutDrawer() {
    return Scaffold(
        key: widget.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.createShipment.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: widget.closeButtonWidget ?? const Offstage(),
            leadingWidth: widget.leadingWidth ?? 27,
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              color: AppColors.backgroundColor,
              width: Get.width,
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    onGetTopProgressTab(),
                    widget.body ?? const Offstage(),
                    widget.bottomBar ?? const Offstage(),
                  ],
                ),
              ),
            ),
          ),
        ));
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
      () => InkWell(
        onTap: () {
          // if(menuIndex!=controller.currentTab.value){
          //   if(menuIndex==0){
          //     controller.currentTab.value=0;
          //     Get.back();
          //   }else if(menuIndex==1){
          //     controller.currentTab.value=1;
          //     Get.toNamed(RouteName.coParcelsPage);
          //   }
          // }
        },
        child: Column(
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
      ),
    );
  }
}
