import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/apply_waybills/apply_way_bills/presentation/controllers/apply_waybills_controller.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

class WayBillsAddressView extends GetResponsiveView<ApplyWayBillsController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final addressList = <String>[].obs;

  List<String> addressListShow = [
    "Canada",
    "Brazil",
    "USA",
    "Japan",
    "China",
    "UK",
    "Uganda",
    "Uruguay"
  ];

  @override
  Widget? builder() {
    addressList.value = addressListShow;
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
        padding: EdgeInsets.all(0),
        key: scaffoldKey,
        alignment: AlignmentDirectional.topCenter,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.address.tr,
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              onGetSearchView(false),
              const SizedBox(
                height: 10,
              ),
              onGetOrderList(false)
            ],
          ),
        ));
  }

  @override
  Widget? tablet() {
    return Template(
        padding: EdgeInsets.all(0),
        key: scaffoldKey,
        alignment: AlignmentDirectional.topCenter,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.address.tr,
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              onGetSearchView(false),
              const SizedBox(
                height: 10,
              ),
              onGetOrderList(false)
            ],
          ),
        ));
  }

  @override
  Widget? desktop() {
    return Template(
        padding: EdgeInsets.all(0),
        key: scaffoldKey,
        alignment: AlignmentDirectional.topCenter,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width/3),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.address.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 50,
              centerTitle: true,
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              onGetSearchView(true),
              const SizedBox(
                height: 10,
              ),
              onGetOrderList(true)
            ],
          ),
        ));
  }


  onGetSearchView(bool isWeb) {
    return Container(
      color: AppColors.searchBgColor,
      width: isWeb ? Get.width / 3.2 : double.infinity,
      // padding: isWeb
      //     ? EdgeInsets.only(left: 292, right: 292, bottom: 10, top: 0)
      //     : EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 0),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
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
                  print("value ===>>> $value");
                } else {
                  addressList.value.clear();
                  addressListShow.forEach((item) {
                    if (item.contains(value)) {
                      List<String> dummy = [];
                      dummy.addAll(addressList.value);
                      dummy.add(item);
                      addressList.value = dummy;
                    }
                  });
                }
              },
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.address.tr,
                hintStyle: _appTheme.customTextStyle(
                    fontSize: 15,
                    fontFamilyType: FFT.nunito,
                    color: AppColors.blackColor,
                    fontWeightType: FWT.regular),
                filled: true,
                fillColor: AppColors.searchBgColor,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            child: SvgPicture.asset(
              SVGPath.closeIcon,
              width: 15,
              color: AppColors.secondaryColor,
            ).marginOnly(left: 10, right: 10),
            onTap: () {
              controller.editConSearch.clear();
              Utils.hideKeyboard();
            },
          )
        ],
      ),
    );
  }

  onGetOrderList(bool isWeb) {
    return Container(
        width: isWeb ? Get.width / 3.2 : double.infinity,
        child: Obx(() => ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                color: index % 2 == 0
                    ? AppColors.listOddColor
                    : AppColors.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    addressList[index],
                    style: _appTheme.customTextStyle(
                        fontSize: 15,
                        color: AppColors.blackColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
              );
            })));
  }
}
