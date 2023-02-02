import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../exceptions/app_exception.dart';
import '../generated/locales.g.dart';
import '../logger/logger.dart';

class UseCase {
  String getMessage(Exception e) {
    if (e is CustomException) {
      return e.message.toString();
    }
    return LocaleKeys.noInternetConnection.tr;
  }

  void l(dynamic s) {
    Logger.write(s);
  }
}
