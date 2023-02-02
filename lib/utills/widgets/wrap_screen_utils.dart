import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme.dart';

class WrapScreenUtils extends StatelessWidget {
  final Widget child;

  const WrapScreenUtils({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(AppThemeState.expectedDeviceWidth,
          AppThemeState.expectedDeviceHeight),
      builder: (BuildContext context, child1) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child)),
    );
  }
}
