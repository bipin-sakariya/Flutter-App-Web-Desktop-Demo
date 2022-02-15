// ignore_for_file: avoid_print, file_names

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class InternetConnection {
  bool? _internetStatus = false;

  Future<bool> checkConnection() async {
    ConnectivityResult result;
    final Connectivity connectivity = Connectivity();
    try {
      result = await connectivity.checkConnectivity();
      print("===>${result}");
      switch (result) {
        case ConnectivityResult.wifi:
          _internetStatus = true;
          return true;
        case ConnectivityResult.mobile:
          _internetStatus = true;
          return true;
        default:
          _internetStatus = false;
          return false;
      }
    } on PlatformException catch (e) {
      print("===>Catch${e.message}");
      _internetStatus = false;
      return false;
    }
  }
}
