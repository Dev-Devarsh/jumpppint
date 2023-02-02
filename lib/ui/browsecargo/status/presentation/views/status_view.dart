import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/shipment_tracking/model/item_detail.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/circle_view.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/generated/locales.g.dart';
import '../controllers/status_controller.dart';

class StatusView extends GetResponsiveView<StatusController> {

  List<StatusLogs> statusLogsList = [];

  StatusView({Key? key, required this.statusLogsList}) : super(key: key);

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
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 700),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 100,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: onGetStatusUpdate(),
                ),
               /* Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: onGetPhotoProof(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                  child: onGetSignatureProof(),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget? tablet() {
    return desktop();
  }

  @override
  Widget? desktop() {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: onGetStatusUpdate(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 30,
                  left: screen.isTablet ? 50 : 0,
                  right: screen.isTablet ? 50 : 0),
              child: Row(
                children: [
                  Expanded(child: onGetPhotoProof()),
                  SizedBox(width: screen.isTablet ? 20 : 10),
                  Expanded(child: onGetSignatureProof()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onGetStatusUpdate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          child: VerticalDivider(
            thickness: 1,
            color: AppColors.textSecondaryColor,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statusLogsList.length,
            itemBuilder: (BuildContext context, int index) {
              return IntrinsicHeight(
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        VerticalDivider(
                          thickness: 1,
                          color: AppColors.textSecondaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: CircleView(
                            color: AppColors.textSecondaryColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            onCommonTextFormField(
                                statusLogsList[index].status, 16, AppColors.textPrimaryColor),
                            const SizedBox(
                              height: 5,
                            ),
                            onCommonTextFormField(Utils.apiDateFormet(statusLogsList[index].createdAt), 14,
                                AppColors.textPrimaryColor),
                            const SizedBox(
                              height: 5,
                            ),
                            /*onCommonTextFormField(
                                "快遞員已在【寄件地址】快遞員已在【寄件地址】快遞員已在【寄件地址】快遞員已在【寄件地址】",
                                14,
                                AppColors.textSecondaryColor),*/
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }

  onGetPhotoProof() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              onCommonTextFormField(
                  LocaleKeys.photoProof.tr, 14, AppColors.textSecondaryColor),
              onCommonTextFormField(
                  LocaleKeys.save.tr, 14, AppColors.primaryColor)
            ],
          ).paddingOnly(top: 15, bottom: 7, left: 10, right: 10),
          Image.asset(
            fit: BoxFit.fill,
            PNGPath.dummyPhotoProof,
            // height: Get.width - 160,
            // width: double.infinity,
          ).paddingOnly(left: 10, right: 10, bottom: 10)
        ],
      ),
    );
  }

  onGetSignatureProof() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              onCommonTextFormField(LocaleKeys.signatureProof.tr, 14,
                  AppColors.textSecondaryColor),
              onCommonTextFormField(
                  LocaleKeys.save.tr, 14, AppColors.primaryColor)
            ],
          ).paddingOnly(top: 15, bottom: 7, left: 10, right: 10),
          Image.asset(
            fit: BoxFit.fill,
            PNGPath.dummyPhotoProof,
            // height: Get.width - 160,
            // width: double.infinity,
          ).paddingOnly(left: 10, right: 10, bottom: 10)
        ],
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
