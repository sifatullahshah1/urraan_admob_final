import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/appopen_ad_helper.dart';
import 'package:flutter_admob_code/admob/interstitial_ad_helper.dart';

class ScreenInterstitials extends StatefulWidget {
  const ScreenInterstitials({super.key});

  @override
  State<ScreenInterstitials> createState() => _ScreenInterstitialsState();
}

class _ScreenInterstitialsState extends State<ScreenInterstitials> {
  InterstitialAdHelper interstitialAdHelper = InterstitialAdHelper();

  @override
  void initState() {
    super.initState();

    interstitialAdHelper.loadInterstitialAds(
      onAdDismissed: () {
        Future.delayed(Duration(seconds: 30), () {
          MyAppState().updateValue(false); // enable open ads after 30 sec
        });
        DoNextFunctionality();
      },
      onAdShowFullScreen: () {
        MyAppState().updateValue(true); // disabled app open ads
      },
    );
  }

  DoNextFunctionality() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            if (interstitialAdHelper.isAdLoaded) {
              interstitialAdHelper.showAdIfAvailable();
            } else {
              DoNextFunctionality();
            }
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text("Second Screen"),
      ),
    );
  }
}
