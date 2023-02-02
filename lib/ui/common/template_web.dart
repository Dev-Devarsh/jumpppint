import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/home/presentation/controllers/home_controller.dart';
import 'package:jumppoint_app/utills/colors.dart';

import 'custom_drawer.dart';

class TemplateWeb extends StatefulWidget {
  const TemplateWeb(
      {Key? key,
      required this.body,
      this.padding,
      this.alignment,
      this.currentTab})
      : super(key: key);

  final Widget? body;
  final EdgeInsets? padding;
  final AlignmentDirectional? alignment;
  final int? currentTab;

  @override
  State<TemplateWeb> createState() => _TemplateWebState();
}

class _TemplateWebState extends State<TemplateWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Align(
            alignment: widget.alignment ?? AlignmentDirectional.center,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: CommonDrawer(
                        currentIndex: RxInt(widget.currentTab ?? 0), onLogoutClick: () {
                      Get.find<HomeController>().logout();
                    },)),
                Expanded(
                  flex: 11,
                  child: widget.body ?? const Offstage(),
                )
              ],
            ),
          ),
        ));
  }
}
