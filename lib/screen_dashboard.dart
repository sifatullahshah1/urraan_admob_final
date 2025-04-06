import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/appopen_ad_helper.dart';
import 'package:flutter_admob_code/screen_banner_ads.dart';
import 'package:flutter_admob_code/screen_interstitials.dart';
import 'package:flutter_admob_code/screen_native_ads.dart';
import 'package:flutter_admob_code/screen_rewarded_ads.dart';
import 'package:flutter_admob_code/screen_rewarded_interstitial_ads.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard>
    with WidgetsBindingObserver {
  AppOpenAdHelper appOpenAdHelper = AppOpenAdHelper();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed &&
        !MyAppState().getIsOtherAdsDisabled) {
      appOpenAdHelper.showAdIfAvailable();
    }
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    appOpenAdHelper.loadAppOpenAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ScreenBannerAds()));
                },
                child: Text("Open Screen Banner"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ScreenInterstitials()));
                },
                child: Text("Open Screen Interstitials"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ScreenNativeAds()));
                },
                child: Text("Open Native Screen"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ScreenRewardedAds()));
                },
                child: Text("Open Rewarded Screen"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              ScreenRewardedInterstitialAds()));
                },
                child: Text("Open Rewarded Interstitial Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
