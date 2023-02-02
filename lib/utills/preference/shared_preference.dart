import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logger/logger.dart';
import '../pref_keys.dart';

class SharedPreferenceController extends GetxController {
  // FlutterSecureStorage? _securePref;
  SharedPreferences? _pref;

  @override
  Future<void> onInit() async {
    Logger.write('@17 shared pref init called');
    try {
      await initPreference();
    } catch (e) {
      Logger.write("$e");
    }
    super.onInit();
  }

  bool isPrefNull() {
    return _pref == null;
  }

  @override
  void onClose() {
    _pref = null;
  }

  Future<bool?> clearData() async {
    Logger.write('xxxxxxxxxx---Clear Data---xxxxxxxxxx');
    await _pref?.clear();
    return Future.value(true);
  }

  Future<bool> initPreference() async {
    _pref ??= await SharedPreferences.getInstance();
    return Future.value(true);
  }

  Future<void>? saveData(String key, dynamic value) {
    debugPrint("_pref $key : $value");
    return _pref?.setString(key, value.toString());
  }

  Future<void>? saveBool(String key, bool value) {
    debugPrint("_pref $key : $value");
    return _pref?.setBool(key, value);
  }

  String? getData(String key) {
    try {
      return _pref?.getString(key);
    } on PlatformException {
      Logger.write('PlatformException: unable to read the error');
      return null;
    } on Exception catch (e) {
      Logger.write('unable to read the error $e');
      return null;
    }
  }

  Future<void>? saveNormal(String key, String value) {
    return _pref?.setString(key, value);
  }

  String? getNormal(String key) {
    return _pref?.getString(key);
  }

  void removeNormal(String key) {
    _pref?.remove(key);
  }

  /*Future<User?> getUser() async {
    String? data = getNormal(PrefKeys.user);
    if (data != null) {
      try {
        return User.fromJson(jsonDecode(data));
      } catch (e) {
        Logger.write('got error $e');
        return null;
      }
    } else {
      return null;
    }
  }*/

  Future<void>? saveToken(String key, String value) {
    Logger.write('save Token $key and $value');
    return _pref?.setString(key, value.toString());
  }

  // void logout() {
  //   setLogin(false);
  //   _pref?.remove(PrefKeys.user);
  // }

  String? getToken(String key) {
    return _pref?.getString(key);
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    debugPrint("isLogin,${_pref?.getBool(PrefKeys.isLogin)}");
    return pref.getBool(PrefKeys.isLogin) ?? false;
  }

  bool getBool(String key) {
    return _pref!.getBool(key) ?? false;
  }

  void logout() {
    setLogin(false);
    _pref?.remove(PrefKeys.user);
    _pref?.remove(PrefKeys.token);
    _pref?.remove(PrefKeys.refreshToken);
    _pref?.remove(PrefKeys.refreshToken);
  }
Future<void>? setLogin(bool value) {
  print("isLogin,$value");
  return _pref?.setBool(PrefKeys.isLogin, value);
}
}
