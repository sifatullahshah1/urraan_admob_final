import 'dart:io';

import 'package:flutter/foundation.dart';

class AdmobManager {
  static const Map<String, String> _testIds = {
    "appId": "ca-app-pub-3940256099942544~3347511713",
    "banner": "ca-app-pub-3940256099942544/9214589741",
    "interstitial": "ca-app-pub-3940256099942544/1033173712",
    "rewarded": "ca-app-pub-3940256099942544/1033173712",
    "native": "ca-app-pub-3940256099942544/2247696110",
    "appOpen": "ca-app-pub-3940256099942544/9257395921",
  };

  //=============== Real Android Ids ===========================================
  static const Map<String, String> _androidIds = {
    "appId": "",
    "banner": "",
    "interstitial": "",
    "rewarded": "",
    "native": "",
    "appOpen": "",
  };
//=============== Real Android Ids ===========================================

//================ Real IOS Ids ================================================
  static const Map<String, String> _iosIds = {
    "appId": "",
    "banner": "",
    "interstitial": "",
    "rewarded": "",
    "native": "",
    "appOpen": "",
  };
//================ Real IOS Ids ================================================

  static Map<String, String> get _ids => kDebugMode
      ? _testIds
      : Platform.isAndroid
          ? _androidIds
          : _iosIds;

  static String get appId => _ids["appId"]!;
  static String get banner => _ids["banner"]!;
  static String get interstitial => _ids["interstitial"]!;
  static String get rewarded => _ids["rewarded"]!;
  static String get native => _ids["native"]!;
  static String get appOpen => _ids["appOpen"]!;
}
