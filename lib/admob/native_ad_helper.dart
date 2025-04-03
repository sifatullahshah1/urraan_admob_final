import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdHelper {
  NativeAd? _nativeAd;
  bool isLoaded = false;

  void loadNativeAd(Function() onAdLoaded,
      {TemplateType type = TemplateType.small}) {
    _nativeAd = NativeAd(
      adUnitId: AdmobManager.nativeId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          isLoaded = true;
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          print("NativeAd failed to load: $error");
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: type,
        mainBackgroundColor: const Color(0xfffffbed),
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.italic,
            size: 16.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
      ),
    )..load();
  }

  NativeAd? get nativeAd => isLoaded ? _nativeAd : null;

  void dispose() {
    _nativeAd?.dispose();
  }

  static Widget getNativeAdView(
      {required bool isPurchase,
      required bool isLoaded,
      required NativeAd? nativeAd,
      double height = 100}) {
    return isPurchase
        ? const SizedBox()
        : isLoaded && nativeAd != null
            ? Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                    height: height,
                    width: double.infinity,
                    child: AdWidget(ad: nativeAd)),
              )
            : const SizedBox(height: 0);
  }
}

// final NativeAdHelper nativeAdHelper = NativeAdHelper();
//
// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   nativeAdHelper.loadNativeAd(() {
//     setState(() {});
//   });
// }
//
// @override
// void dispose() {
//   nativeAdHelper.dispose();
//   super.dispose();
// }
//
// NativeAdHelper.getNativeAdView(
// isPurchase: false,
// isLoaded: nativeAdHelper.isLoaded,
// nativeAd: nativeAdHelper.nativeAd,
// height: 120,
// ),
