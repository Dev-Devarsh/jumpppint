import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumppoint_app/utills/colors.dart';

class Template extends StatefulWidget {
  const Template(
      {Key? key, required this.body, this.appBar, this.width, this.padding,this.alignment,this.backgroundColor})
      : super(key: key);

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final double? width;
  final EdgeInsets? padding;
  final AlignmentDirectional? alignment;
  final Color? backgroundColor;

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return widget.appBar != null ? onGetBodyWithBar() : onGetBodyWithoutBar();
  }

  onGetBodyWithBar() {
    return Scaffold(
        appBar: widget.appBar,
        body: SafeArea(
          child: Align(
            alignment: widget.alignment??AlignmentDirectional.center,
            child: SingleChildScrollView(
              child: Container(
                color: widget.backgroundColor ?? AppColors.backgroundColor,
                padding: widget.padding ??
                    const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                width: widget.width ?? Get.width,
                child: widget.body ?? const Offstage(),
              ),
            ),
          ),
        ));
  }

  onGetBodyWithoutBar() {
    return Scaffold(
        body: SafeArea(
      child: Align(
        alignment: widget.alignment??AlignmentDirectional.center,
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.backgroundColor,
            padding: widget.padding ??
                const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
            width: widget.width ?? Get.width,
            child: widget.body ?? const Offstage(),
          ),
        ),
      ),
    ));
  }
}
