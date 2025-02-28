import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/interstitial_ad_helper.dart';

class ScreenSecond extends StatefulWidget {
  const ScreenSecond({super.key});

  @override
  State<ScreenSecond> createState() => _ScreenSecondState();
}

class _ScreenSecondState extends State<ScreenSecond> {
  InterstitialAdHelper interstitialAdHelper = InterstitialAdHelper();

  @override
  void initState() {
    super.initState();

    interstitialAdHelper.loadInterstitialAds(
      onAdDismissed: () {
        DoNextFunctionality();
      },
      onAdShowFullScreen: () {},
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
            interstitialAdHelper.showAdIfAvailable();
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text("Second Screen"),
      ),
    );
  }
}
