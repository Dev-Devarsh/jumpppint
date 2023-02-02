import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/languagesetting/domain/language_settings_user_case.dart';
import 'package:jumppoint_app/utills/generated/language_model.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class LanguageSettingsController extends SuperController {
  final ProgressController progressController;
  final LanguageSettingsUseCase languageSettingsUseCase;
  final SharedPreferenceController sharedPreferenceController;

  LanguageSettingsController(this.progressController, this.languageSettingsUseCase,
      this.sharedPreferenceController);

  RxInt currentType = 0.obs;

  final listLangNameLocale = <LanguageModel>[
    LanguageModel(languageName: 'traditionalChinese', langLocal: const Locale('zh_TW', '')),
    LanguageModel(languageName: "simplifiedChinese", langLocal: const Locale('zh_CN', '')),
    LanguageModel(languageName: "English", langLocal: const Locale('en', '')),
  ];

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    String lanCode = sharedPreferenceController.getNormal(PrefKeys.keyLanguageCode)??"";
    if(lanCode==""){
      currentType.value = 3;
      updateLang(3);
    }else{
      for (int i = 0; i < listLangNameLocale.length; i++) {
        if (listLangNameLocale[i].langLocal.languageCode == lanCode) {
          currentType.value = i+1;
          break;
        }
      }
    }
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed
  }

  void updateLang(int index){
    print("object===>>> ${listLangNameLocale[index-1].langLocal.languageCode}");
    print("object===>>> ${listLangNameLocale[index-1].langLocal.countryCode ?? ""}");
    print("object===>>> ${listLangNameLocale[index-1].languageName}");
    saveLanguageData(listLangNameLocale[index-1].langLocal.languageCode,
        listLangNameLocale[index-1].langLocal.countryCode ?? "",
        listLangNameLocale[index-1].languageName,
      );
      Get.updateLocale(listLangNameLocale[index-1].langLocal);
  }

  void saveLanguageData(
      String languageCode, String countryCode, String languageName) {
    sharedPreferenceController.saveNormal(PrefKeys.keyLanguageCode, languageCode);
    sharedPreferenceController.saveNormal(PrefKeys.keyCountryCode, countryCode);
    sharedPreferenceController.saveNormal(PrefKeys.keyLanguageName, languageName);
  }
}
