import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

///
/// This class checks if device has internet connectivity or not
///
class NetworkManager {
  static NetworkManager? _instance;

  static NetworkManager? getInstance() {
    _instance ??= NetworkManager();
    return _instance;
  }

  bool isDialogOpen = false;
  bool? isConnected = true;

  Connectivity connectivity = Connectivity();

  final StreamController<bool?> _networkStreamController =
      StreamController.broadcast();

  Stream get networkStream => _networkStreamController.stream;

  void initialiseNetworkManager() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isInternet = false;
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
    if (isInternet) {
      _networkStreamController.sink.add(await _updateConnectionStatus());
    } else {
      isConnected = isInternet;
      _networkStreamController.sink.add(isInternet);
    }
  }

  Future<bool?> _updateConnectionStatus() async {
    bool? isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      return false;
    }
    this.isConnected = isConnected;
    return isConnected;
  }

  updateStreamBuilder(bool isInternet) {
    _networkStreamController.sink.add(isInternet);
  }

  void disposeStream() => _networkStreamController.close();
}
