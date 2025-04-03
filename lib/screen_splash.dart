import 'package:flutter/material.dart';
import 'package:flutter_admob_code/screen_dashboard.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void toCheckConsent() {
    final params = ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        var req = await ConsentInformation.instance.isConsentFormAvailable();
        if (req) {
          loadForm();
        } else {
          _navigateToNextScreen();
        }
      },
      (FormError error) => _navigateToNextScreen(),
    );
  }

  void loadForm() {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.required) {
          TimerCheckResult();
          consentForm.show(
            (FormError? formError) {
              _navigateToNextScreen();
            },
          );
        } else {
          _navigateToNextScreen();
        }
      },
      (formError) {
        _navigateToNextScreen();
      },
    );
  }

  void TimerCheckResult() async {
    var status = await ConsentInformation.instance.getConsentStatus();
    if (status == ConsentStatus.obtained) {
    } else {
      await Future.delayed(const Duration(seconds: 2));
      TimerCheckResult();
    }
  }

  loadData() {
    Future.delayed(const Duration(seconds: 5)).then((onValue) async {
      await MobileAds.instance.initialize();
      toCheckConsent();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _navigateToNextScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => ScreenDashboard()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Flutter Admob Ads",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
