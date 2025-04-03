import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_manage.dart';

class RewardedAdHelper {
  bool isAdLoaded = false;
  RewardedAd? _rewardedAd;

  void loadRewardedAd({
    required Function(RewardItem reward) onEarnedReward,
    required Function() onAdShowFullScreen,
    required Function() onAdDismissed,
  }) {
    RewardedAd.load(
      adUnitId: AdmobManager.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          isAdLoaded = true;
          _rewardedAd = ad;

          _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd rewardedAd) {
              onAdShowFullScreen();
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              isAdLoaded = false;
              _rewardedAd = null;
              onAdDismissed();
              loadRewardedAd(
                onEarnedReward: onEarnedReward,
                onAdDismissed: onAdDismissed,
                onAdShowFullScreen: onAdShowFullScreen,
              );
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
              _rewardedAd = null;
              isAdLoaded = false;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("RewardedAd failed to load: $error");
          isAdLoaded = false;
        },
      ),
    );
  }

  void showAdIfAvailable(Function(RewardItem reward) onEarnedReward) {
    if (_rewardedAd != null && isAdLoaded) {
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        onEarnedReward(rewardItem);
      });
    }
  }

  void dispose() {
    _rewardedAd?.dispose();
  }
}

// final RewardedAdHelper rewardedAdHelper = RewardedAdHelper();
//
// @override
// void initState() {
//   super.initState();
//
//   rewardedAdHelper.loadRewardedAd(
//     onEarnedReward: (reward) {
//       print("User earned reward: ${reward.amount}");
//       Future.delayed(Duration(seconds: 30), () {
//         MyAppState().updateValue(false); // enable open ads after 30 sec
//       });
//     },
//     onAdDismissed: () {
//       Future.delayed(Duration(seconds: 30), () {
//         MyAppState().updateValue(false); // enable open ads after 30 sec
//       });
//     },
//     onAdShowFullScreen: () {
//       MyAppState().updateValue(true); // disabled app open ads
//     },
//   );
// }
//
// @override
// void dispose() {
//   rewardedAdHelper.dispose();
//
//   super.dispose();
// }

// ElevatedButton(
// onPressed: () {
// rewardedAdHelper.showAdIfAvailable((reward) {
// print("✔ Rewarded: ${reward.amount} ${reward.type}");
// });
// },
// child: const Text("Show Rewarded Ad"),
// ),
