import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 200.h,
      child: Center(
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: CircularProgressIndicator(
            strokeWidth: 8.w,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
