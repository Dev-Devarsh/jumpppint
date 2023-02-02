import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'exceptions/app_exception.dart';
import 'generated/locales.g.dart';
import 'logger/logger.dart';

extension Message on Exception {
  String getMessage() {
    if (this is CustomException) {
      if ((this as CustomException).message.isNotEmpty) {
        return (this as CustomException).message.toString();
      } else {
        return 'Unable to complete this request. Please try again';
      }
    }
    return LocaleKeys.noInternetConnection.tr;
  }
}

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setHeight(this);

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);

  ///[ScreenUtil.defaultSize]
  double get sp => ScreenUtil().setSp(this);
}

// extension FirstWhereExt<T> on Iterable<T> {
//   /// The first element satisfying [test], or `null` if there are none.
//   T? firstWhereOrNull(bool Function(T element) test) {
//     for (var element in this) {
//       if (test(element)) return element;
//     }
//     return null;
//   }
// }

NavigatorState? get navigator => GetNavigation(Get).key.currentState;

extension MyExtensionBottomSheet on GetInterface {
  void closeBS<T>(String routeName) {
    navigator?.popUntil((route) {
      return (route.settings.name != routeName);
    });
  }

  void closeOverlay<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    //TODO: This code brings compatibility of the new snackbar with GetX 4,
    // remove this code in version 5
    if (isSnackbarOpen && !closeOverlays) {
      closeCurrentSnackbar();
      return;
    }

    if (closeOverlays && isOverlaysOpen) {
      //TODO: This code brings compatibility of the new snackbar with GetX 4,
      // remove this code in version 5
      if (isSnackbarOpen) {
        closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!isDialogOpen! && !isBottomSheetOpen!);
      });
    }
  }
}

extension GetValue on Map {
  dynamic getValue(String key) {
    if (containsKey(key)) {
      return this[key];
    } else {
      return null;
    }
  }
}

extension Logs on GetxController {
  void l(dynamic s) {
    Logger.write(s);
  }
}
