import '../logger/logger.dart';
import '../utils.dart';

abstract class AppException implements Exception {
  void onException(
      {Function()? onButtonClick,
      String title,
      Function()? onDismissClick,
      String buttonText,
      String dismissButtonText});
}

class CustomException extends AppException {
  dynamic message;

  CustomException(this.message, {bool isTimeOut = false});

  @override
  void onException(
      {Function()? onButtonClick,
      String title = "Sorry",
      Function()? onDismissClick,
      String buttonText = "Ok",
      String? dismissButtonText}) {
    Logger.write(message.toString());
    Utils.showCommonDialog(
      title: title,
      positiveText: buttonText,
      onTap: () {},
      onNegativeTap: () {},
    );
  }
}

class NoInternetException extends AppException {
  String message;

  NoInternetException(this.message);

  @override
  void onException(
      {Function()? onButtonClick,
      String? title,
      Function()? onDismissClick,
      String? buttonText,
      String? dismissButtonText}) {
    // TODO: implement onException
  }
}

class InvalidTokenException extends AppException {
  String message;

  InvalidTokenException(this.message);

  @override
  void onException(
      {Function()? onButtonClick,
      String? title,
      Function()? onDismissClick,
      String? buttonText,
      String? dismissButtonText}) {
    Logger.write(message);
    Utils.showCommonDialog(
      title: title,
      positiveText: buttonText,
      onTap: () {},
      onNegativeTap: () {},
    );
  }
}
