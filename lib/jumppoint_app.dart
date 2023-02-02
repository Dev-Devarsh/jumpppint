import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:jumppoint_app/utills/widgets/custom_progress_dialog.dart';

import 'di/di.dart';

class JumpPointApp extends StatelessWidget {
  ProgressController progressController = DependencyProvider.get();
  ConnectionController connectionController = DependencyProvider.get();
  final Widget child;

  JumpPointApp(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppThemeState appTheme = AppTheme.of(context);
    return Stack(
      children: <Widget>[
        Obx(
          () => IgnorePointer(
              ignoring: progressController.progressDialogStreamController.value,
              child: child),
        ),
        StreamBuilder<bool?>(
            initialData: true,
            stream: connectionController.internetConnectionStream,
            builder: (context, snapshot) {
              return SafeArea(
                child: AnimatedContainer(
                    height: snapshot.data as bool ? 0 : 40.h,
                    duration: Utils.animationDuration,
                    color: AppColors.textPrimaryColor,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Center(
                          child: Text(LocaleKeys.noInternetConnection.tr,
                              style: appTheme.textStyleMontMedium(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ))),
                    )),
              );
            }),
        Obx(() {
          debugPrint(
              "@42 ${progressController.progressDialogStreamController.value}");
          return Center(
            child: Visibility(
              visible: progressController.progressDialogStreamController.value,
              child: const CustomProgressDialog(),
            ),
          );
        }),
      ],
    );
  }
}
