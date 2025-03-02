import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/admob_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdHelper {
  BannerAd? _bannerAd;
  bool isLoaded = false;

  Future<void> loadBannerAd(BuildContext context, Function() onAdLoaded,
      {int height = 100}) async {
    _bannerAd = BannerAd(
      size: AdSize(
          width: MediaQuery.of(context).size.width.truncate(), height: height),
      adUnitId: AdmobManager.bannerAdaptiveId,
      listener: BannerAdListener(onAdLoaded: (asdf) {
        isLoaded = true;
        onAdLoaded();
      }, onAdFailedToLoad: (ad, LoadAdError loadAdError) {
        print("loadAdError ${loadAdError.message}");
        print("loadAdError ${loadAdError.code}");
      }),
      request: const AdRequest(),
    )..load();
  }

  BannerAd? get bannerAd => isLoaded ? _bannerAd : null;

  static Widget getBannerView(
      bool isPurchase, bool isLoaded, BannerAd? bannerAd) {
    return isPurchase
        ? SizedBox()
        : Container(
            color: Colors.grey.shade100,
            padding: EdgeInsets.symmetric(vertical: 5),
            height: isLoaded ? bannerAd!.size.height.toDouble() : 100,
            width: double.infinity,
            child: isLoaded ? AdWidget(ad: bannerAd!) : SizedBox(),
          );
  }

  // BannerAdHelper bannerAdHelper = BannerAdHelper();

  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   bannerAdHelper.loadBannerAd(context, () {
  //     setState(() {});
  //   }, height: 200);
  // }

  // bottomNavigationBar: BannerAdHelper.getBannerView(
  // false, bannerAdHelper.isLoaded, bannerAdHelper.bannerAd),
}
