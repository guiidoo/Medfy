import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  StreamController<bool>? _connectivityController;

  void initialize() {
    _connectivityController = StreamController.broadcast();
  }

  Future<bool> checkConnectivity() async {
    List<ConnectivityResult> listConnectivity = await _connectivity
        .checkConnectivity();
    return verifyStatusConnectivity(listConnectivity);
  }

  bool verifyStatusConnectivity(List<ConnectivityResult> list) {
    if (list.contains(ConnectivityResult.none) && list.length == 1) {
      print("Você esta sem internet");

      _connectivityController?.add(false);

      return false;
    }

    print("Você esta conectado");

    for (ConnectivityResult result in list) {
      if (result == ConnectivityResult.wifi) {
        print("Você está conectadp via Wi-Fi");
      }
      if (result == ConnectivityResult.mobile) {
        print("Você está conectadp via dados moveis");
      }
      if (result == ConnectivityResult.ethernet) {
        print("Você está conectadp via cabo");
      }
    }

    _connectivityController?.add(true);
    return true;
  }

  Stream<bool> get connectivityStream {
    if (_connectivityController == null) {
      initialize();
    }
    return _connectivityController!.stream;
  }

  void dispose() {
    _connectivityController?.close();
  }
}
