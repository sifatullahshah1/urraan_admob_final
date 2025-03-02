import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:flutter_admob_code/admob/appopen_ad_helper.dart';
import 'package:flutter_admob_code/admob/banner_ad_helper.dart';
import 'package:flutter_admob_code/screen_second.dart';

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
    if (state == AppLifecycleState.resumed) {
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

    print(AdmobManager.appId);
    print(AdmobManager.bannerAdaptiveId);
    print(AdmobManager.bannerFixedId);
    print(AdmobManager.interstitialId);
    print(AdmobManager.rewardedInterstitialId);
    print(AdmobManager.rewardedId);
    print(AdmobManager.nativeId);
    print(AdmobManager.nativeVideoId);
    print(AdmobManager.appOpenId);

    WidgetsBinding.instance.addObserver(this);
    appOpenAdHelper.loadAppOpenAd();
  }

  //
  BannerAdHelper bannerAdHelper = BannerAdHelper();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerAdHelper.loadBannerAd(context, () {
      setState(() {});
    }, height: 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      bottomNavigationBar: BannerAdHelper.getBannerView(
          false, bannerAdHelper.isLoaded, bannerAdHelper.bannerAd),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ScreenSecond()));
            },
            child: Text("Open Second Screen"),
          ),
        ),
      ),
    );
  }
}
