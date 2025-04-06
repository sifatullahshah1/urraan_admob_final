import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/banner_ad_helper.dart';

class ScreenBannerAds extends StatefulWidget {
  const ScreenBannerAds({super.key});

  @override
  State<ScreenBannerAds> createState() => _ScreenBannerAdsState();
}

class _ScreenBannerAdsState extends State<ScreenBannerAds> {
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text("Banner Ads"),
      ),
      bottomNavigationBar: BannerAdHelper.getBannerView(
          false, bannerAdHelper.isLoaded, bannerAdHelper.bannerAd),
      body: Center(),
    );
  }
}
