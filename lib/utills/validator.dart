import 'package:get/get.dart';

import 'generated/locales.g.dart';

class Validator {
  static String? emptyValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorEmptyField.tr;
    } else {
      return null;
    }
  }

  static String? locationValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorEmptyLocation.tr;
    } else {
      return null;
    }
  }

  static String? countryValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorEmptyCountry.tr;
    } else {
      return null;
    }
  }

  static String? oldPassword(String? value) {
    if (value?.isEmpty == true) {
      return LocaleKeys.errorOldPassword.tr;
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errorInvalidEmailField.tr;
    } else if (!GetUtils.isEmail(value)) {
      return LocaleKeys.errorInvalidEmailField.tr;
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errorPhoneNumberField.tr;
    } else if (value.length > 16 || value.length < 7) {
      return LocaleKeys.errorPhoneNumberField.tr;
    } else {
      return null;
    }
  }

  static String? loginPasswordValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorEnterCompletePassword.tr;
    } else if (value!.length < 8) {
      return LocaleKeys.errorPasswordLengthField.tr;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorEnterCompletePassword.tr;
    } else if (value!.length < 8) {
      return LocaleKeys.errorPasswordLengthField.tr;
    } else if (!validateStructure(value)) {
      return LocaleKeys.errorPasswordSecurity.tr;
    } else {
      return null;
    }
  }

  static RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  // static RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static bool validateStructure(String value) {
    return regExp.hasMatch(value);
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (password.trim().isEmpty) {
      return null;
    }
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errConfPassword.tr;
    } else if (value!.length < 8) {
      return LocaleKeys.errorPasswordLengthField.tr;
    } else if (value != password) {
      return LocaleKeys.errorPasswordNotMatch.tr;
    } else {
      return null;
    }
  }

  static String? usernameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorInvalidEmailField.tr;
    } else if (!GetUtils.isEmail(value!)) {
      return LocaleKeys.errorInvalidEmailField.tr;
    }
    return null;
  }

  static String? emailMobileValidator(String? value) {
    if (value!.isEmpty == false) {
      if (GetUtils.isEmail(value) || GetUtils.isPhoneNumber(value)) {
        return null;
      } else {
        return LocaleKeys.errorEmailOrNumber.tr;
      }
    } else {
      return LocaleKeys.errorEmailOrNumber.tr;
    }
  }

  static String? otpValidator(String? value) {
    if (value != null) {
      if (value.length < 6) {
        return LocaleKeys.errorOtpLength.tr;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? areaCodeValidator(String? value) {
    if (value != null) {
      if (value.length != 3) {
        return LocaleKeys.errorAreaCode.tr;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? emptyCompanyNameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorCompanyName.tr;
    } else {
      return null;
    }
  }

  static String? emptyRemarksValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorRemarks.tr;
    } else {
      return null;
    }
  }

  static String? emptyKnowUsValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorKnowUs.tr;
    } else {
      return null;
    }
  }

  static String? emptyTopAmountValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.errorAmount.tr;
    } else {
      return null;
    }
  }

  static String? smsOtpValidator(String? value) {
    if (value != null) {
      if (value.length != 6) {
        return LocaleKeys.errorOtpLength.tr;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
