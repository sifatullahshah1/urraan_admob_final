import 'package:flutter/material.dart';
import 'package:flutter_admob_code/admob/native_ad_helper.dart';

class ScreenNativeAds extends StatefulWidget {
  const ScreenNativeAds({super.key});

  @override
  State<ScreenNativeAds> createState() => _ScreenNativeAdsState();
}

class _ScreenNativeAdsState extends State<ScreenNativeAds> {
  final NativeAdHelper nativeAdHelper = NativeAdHelper();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nativeAdHelper.loadNativeAd(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nativeAdHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Native Ad Example")),
      body: Column(
        children: [
          Expanded(
            child: Center(child: Text("Main content goes here")),
          ),
          NativeAdHelper.getNativeAdView(
            isPurchase: false,
            isLoaded: nativeAdHelper.isLoaded,
            nativeAd: nativeAdHelper.nativeAd,
            height: 120,
          ),
        ],
      ),
    );
  }
}
