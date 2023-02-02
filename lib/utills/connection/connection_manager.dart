import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../logger/logger.dart';

///
/// This class checks if device has internet connectivity or not
///
class ConnectionController extends GetxController {
  final onInternetConnected = true.obs;

  Stream<bool?> get internetConnectionStream => onInternetConnected.stream;

  Connectivity connectivity = Connectivity();

  bool? _isInternetConnected;

  @override
  void onInit() {
    try {
      initialiseNetworkManager();
    } catch (e) {
      Logger.write("$e");
    }
    super.onInit();
  }

  initialiseNetworkManager() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      Logger.write('connection change $result');
      _checkStatus(result);
    });
  }

  Future<bool?> isConnected() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return await _checkStatus(result);
  }

  Future<bool?> _checkStatus(ConnectivityResult result) async {
    bool? isInternet = false;
    switch (result) {
      case ConnectivityResult.wifi:
        isInternet = true;
        break;
      case ConnectivityResult.mobile:
        isInternet = true;
        break;
      case ConnectivityResult.none:
        isInternet = false;
        break;
      default:
        isInternet = false;
        break;
    }
    // if (isInternet) isInternet = await _updateConnectionStatus();
    if (_isInternetConnected == null || _isInternetConnected != isInternet) {
      _isInternetConnected = isInternet;
      onInternetConnected.value = isInternet;
    }
    Logger.write('internet change to $isInternet');
    return isInternet;
  }

  @override
  void onClose() {
    onInternetConnected.close();
    super.onClose();
  }
}
