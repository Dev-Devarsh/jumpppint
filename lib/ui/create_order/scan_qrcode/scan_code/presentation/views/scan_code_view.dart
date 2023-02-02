import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/template.dart';
import 'package:jumppoint_app/ui/create_order/model/parcel_model.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../utills/asset_images.dart';
import '../../../../../../utills/colors.dart';
import '../../../../../../utills/enum/font_type.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../type/presentation/controllers/type_controller.dart';

class ScanCodeView extends GetResponsiveView<TypeController> {
  final formKey = GlobalKey<FormState>();

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
        backgroundColor: AppColors.lightGreyColor,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.scanCode.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetCloseIcon(),
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      padding: EdgeInsets.all(9),
                      child: ClipRRect(
                        child: MobileScanner(
                            allowDuplicates: false,
                            controller: MobileScannerController(
                                facing: CameraFacing.back,
                                torchEnabled: false,
                                formats: [BarcodeFormat.qrCode]),
                            onDetect: (barcode, args) {
                              if (barcode.rawValue == null) {
                                Logger.dev('Failed to scan Barcode');
                                // screen.isDesktop ?
                                Utils.showCommonDialogWeb(
                                    title: LocaleKeys.invalidQRCode.tr,
                                    isNegativeButtonShow: false,
                                    positiveText: LocaleKeys.ok.tr,
                                    onTap: () {
                                      Get.back();
                                    });
                              } else {
                                final String code = barcode.rawValue ?? '';
                                try {
                                  ParcelModel model =
                                      ParcelModel.fromJson(jsonDecode(code));
                                  controller.onHandleQRData(
                                      model, Get.arguments);
                                  Logger.dev('Barcode found! $code');
                                } catch (e) {
                                  Utils.showCommonDialogWeb(
                                      title: LocaleKeys.invalidQRCode.tr,
                                      isNegativeButtonShow: false,
                                      positiveText: LocaleKeys.ok.tr,
                                      onTap: () {
                                        Get.back();
                                      });
                                }
                              }
                            }),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          PNGPath.qrCodeBg,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0x3f000000),
                          ),
                          child: Text(
                            LocaleKeys.scanCodeOnStickyWayBills.tr,
                            style: AppThemeState().customTextStyle(
                                fontSize: 14,
                                color: AppColors.disableTextColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return Container();
  }

  // MOBILE

  onGetCloseIcon() {
    return InkWell(
      onTap: () {
        // Logger.dev("@71 Close Button Called");
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SvgPicture.asset(
          SVGPath.closeIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
