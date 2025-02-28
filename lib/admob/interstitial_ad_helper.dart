import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  bool isAdLoaded = false;
  InterstitialAd? interstitialAd;

  void loadInterstitialAds(
      {required Function() onAdDismissed,
      required Function() onAdShowFullScreen}) {
    InterstitialAd.load(
      adUnitId: AdmobManager.interstitial,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd interstitialAd) {
          isAdLoaded = true;
          this.interstitialAd = interstitialAd;

          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (InterstitialAd interstitialAd2) {
            isAdLoaded = false;
            this.interstitialAd = null;
            onAdDismissed();
            loadInterstitialAds(
                onAdDismissed: onAdDismissed,
                onAdShowFullScreen: onAdShowFullScreen);
          }, onAdShowedFullScreenContent: (InterstitialAd interstitialAd3) {
            onAdShowFullScreen();
          }, onAdFailedToShowFullScreenContent:
                  (InterstitialAd interstitialAd4, AdError adError) {
            isAdLoaded = false;
            this.interstitialAd?.dispose();
            this.interstitialAd = null;
          });
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
    if (interstitialAd != null && isAdLoaded == true) {
      interstitialAd?.show();
      isAdLoaded = false;
    }
  }

  // InterstitialAdHelper interstitialAdHelper = InterstitialAdHelper();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   interstitialAdHelper.loadInterstitialAds(
  //     onAdDismissed: () {
  //       DoNextFunctionality();
  //     },
  //     onAdShowFullScreen: () {},
  //   );
  // }
  //
  // DoNextFunctionality() {
  //   Navigator.pop(context);
  // }

  // interstitialAdHelper.showAd();
}
