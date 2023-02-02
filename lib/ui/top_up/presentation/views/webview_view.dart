import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/top_up_controller.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScreen extends GetView<WebviewController> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebView(
        initialUrl: controller.url.value,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request){
            return NavigationDecision.navigate;
        },
        onPageFinished: (finish) {
          if (kDebugMode) {
            print("onPageFinished");
          }
        }

    );
  }
}
