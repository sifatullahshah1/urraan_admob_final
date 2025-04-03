import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/appopen_ad_helper.dart';
import 'package:flutter_admob_code/admob/rewarded_ad_helper.dart';

class ScreenRewardedAds extends StatefulWidget {
  const ScreenRewardedAds({Key? key}) : super(key: key);

  @override
  State<ScreenRewardedAds> createState() => _ScreenRewardedAdsState();
}

class _ScreenRewardedAdsState extends State<ScreenRewardedAds> {
  final RewardedAdHelper rewardedAdHelper = RewardedAdHelper();

  @override
  void initState() {
    super.initState();

    rewardedAdHelper.loadRewardedAd(
      onEarnedReward: (reward) {
        print("User earned reward: ${reward.amount}");
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
    rewardedAdHelper.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rewarded Ads")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                rewardedAdHelper.showAdIfAvailable((reward) {
                  print("✔ Rewarded: ${reward.amount} ${reward.type}");
                });
              },
              child: const Text("Show Rewarded Ad"),
            ),
          ],
        ),
      ),
    );
  }
}
