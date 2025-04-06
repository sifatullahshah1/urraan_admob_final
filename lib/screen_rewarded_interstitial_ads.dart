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
            Text(
                "Before rewarded ads showing user should need to have a clear flow that user will watch the ads if button text is clear that next is rewarded ads showing then no need to show information dialog if button text is not clear then first show dialog before rewarded ads"),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Information"),
                      content: Text(
                          "To Download/Access this feature you need to watch the rewarded ads first"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            rewardedInterstitialAdHelper
                                .showAdIfAvailable((reward) {
                              Future.delayed(Duration(seconds: 30), () {
                                MyAppState().updateValue(
                                    false); // enable open ads after 30 sec
                              });
                              Navigator.of(context).pop(); // Closes the dialog
                              print(
                                  "✔ Rewarded Interstitial: ${reward.amount} ${reward.type}");
                            });
                          },
                          child:
                              Text("Watch Ad to Download/Access this feature"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Download"),
            ),
            SizedBox(height: 20),
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
              child: const Text("Watch Ad to Download/Access this feature"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Show Rewarded Interstitial Ad"),
            ),
          ],
        ),
      ),
    );
  }
}
