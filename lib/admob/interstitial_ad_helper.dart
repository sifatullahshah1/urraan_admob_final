import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  bool isAdLoaded = false;
  InterstitialAd? interstitialAd;

  void loadInterstitialAds(
      {required Function() onAdDismissed,
      required Function() onAdShowFullScreen}) {
    InterstitialAd.load(
      adUnitId: AdmobManager.interstitialId,
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
          print("loadAdError Code ${loadAdError.code}");
          print("loadAdError Message ${loadAdError.message}");
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
}

InterstitialAdHelper interstitialAdHelper = InterstitialAdHelper();

// @override
// void initState() {
//   super.initState();
//
//   interstitialAdHelper.loadInterstitialAds(
//     onAdDismissed: () {
//       Future.delayed(Duration(seconds: 30), () {
//         MyAppState().updateValue(false); // enable open ads after 30 sec
//       });
//       DoNextFunctionality();
//     },
//     onAdShowFullScreen: () {
//       MyAppState().updateValue(true); // disabled app open ads
//     },
//   );
// }
//
// DoNextFunctionality() {
//   Navigator.pop(context);
// }

// leading: InkWell(
// onTap: () {
// interstitialAdHelper.showAdIfAvailable();
// },
// child: Icon(Icons.arrow_back_rounded),
// ),
