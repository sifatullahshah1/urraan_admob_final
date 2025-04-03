import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/appopen_ad_helper.dart';
import 'package:flutter_admob_code/admob/rewarded_interstitial_ad_helper.dart';

class ScreenRewardedInterstitialAds extends StatefulWidget {
  const ScreenRewardedInterstitialAds({super.key});

  @override
  State<ScreenRewardedInterstitialAds> createState() =>
      _ScreenRewardedInterstitialAdsState();
}

class _ScreenRewardedInterstitialAdsState
    extends State<ScreenRewardedInterstitialAds> {
  final RewardedInterstitialAdHelper rewardedInterstitialAdHelper =
      RewardedInterstitialAdHelper();

  @override
  void initState() {
    super.initState();

    rewardedInterstitialAdHelper.loadRewardedInterstitialAd(
      onEarnedReward: (reward) {
        print("User earned reward from interstitial: ${reward.amount}");
        Future.delayed(Duration(seconds: 30), () {
          MyAppState().updateValue(false); // enable open ads after 30 sec
        });
      },
      onAdDismissed: () {
        Future.delayed(Duration(seconds: 30), () {
          MyAppState().updateValue(false); // enable open ads after 30 sec
        });
      },
      onAdShowFullScreen: () {
        MyAppState().updateValue(true); // disabled app open ads
      },
    );
  }

  @override
  void dispose() {
    rewardedInterstitialAdHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rewarded Interstitials Ads")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                rewardedInterstitialAdHelper.showAdIfAvailable((reward) {
                  Future.delayed(Duration(seconds: 30), () {
                    MyAppState()
                        .updateValue(false); // enable open ads after 30 sec
                  });
                  print(
                      "✔ Rewarded Interstitial: ${reward.amount} ${reward.type}");
                });
              },
              child: const Text("Show Rewarded Interstitial Ad"),
            ),
          ],
        ),
      ),
    );
  }
}
