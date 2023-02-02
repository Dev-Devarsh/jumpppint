import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/jumppoint_app.dart';
import 'package:jumppoint_app/manager/my_notification_manager.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/utills/app_component_base.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/translate/translation.dart';
import 'package:jumppoint_app/utills/widgets/wrap_screen_utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // handleNotification(message);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 /* FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDqUWmZq5J9UueBXTZRZb8aYeIGOe3tMtU",
          authDomain: "kodris-teacher.firebaseapp.com",
          projectId: "kodris-teacher",
          storageBucket: "kodris-teacher.appspot.com",
          messagingSenderId: "594588754554",
          appId: "1:594588754554:web:05e2490f38c1ad698351c3",
          measurementId: "G-62QYHEF3N6")
  );
  MyNotificationManager().init();*/
  String initialRoute = RouteName.root;
  if(await Get.put(SharedPreferenceController()).isLogin()){
    initialRoute = RouteName.homePage;
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    return runApp(MyApp(
      initialRoute: initialRoute,
    ));
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  String initialRoute;

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    AppComponentBase.registerDependencies();
    super.initState();
    // Add the observer.

    WidgetsBinding.instance.addObserver(this);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    print("initialRoute===>>> ${widget.initialRoute}");
    return AppTheme(
        child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialBinding: GlobalBinding(),
      initialRoute: widget.initialRoute,
      getPages: Routes.routes,
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
      locale: const Locale('en', ''),
      fallbackLocale: const Locale('en', ''),
      translations: Translation(),
      routingCallback: (value) {
        if (kIsWeb) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: AppColors.statusBarColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
          );
        } else {
          if (Platform.isIOS) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
              SystemUiOverlay.top,
              SystemUiOverlay.bottom,
            ]);
          }
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: AppColors.statusBarColor,
              statusBarBrightness:
                  Platform.isAndroid ? Brightness.light : Brightness.dark,
              statusBarIconBrightness:
                  Platform.isAndroid ? Brightness.light : Brightness.dark));
        }
      },
      builder: (context, widget) {
        return WrapScreenUtils(
            child: JumpPointApp(
          widget ?? const Offstage(),
        ));
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
  }
}

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerLazySingleton(() => ProgressController());
    DependencyProvider.registerLazySingleton(() => ConnectionController());
    DependencyProvider.registerLazySingleton(() => SharedPreferenceController());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

logout(){

}