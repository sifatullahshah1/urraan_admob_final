import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdHelper {
  AppOpenAd? appOpenAd;
  bool isAdLoaded = false;

  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdmobManager.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd appOpenAd) {
          this.appOpenAd = appOpenAd;
          this.appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (AppOpenAd appOpenAd2) {
              isAdLoaded = false;
              this.appOpenAd?.dispose();
              this.appOpenAd = null;
              loadAppOpenAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError loadAdError) {
          isAdLoaded = false;
          print(
              "loadAdError code ${loadAdError.code}, message ${loadAdError.message}");
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (appOpenAd == null && !isAdLoaded) {
      loadAppOpenAd();
      return;
    } else {
      appOpenAd?.show();
      isAdLoaded = false;
    }
  }
}
