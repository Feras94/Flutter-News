import 'package:firebase_admob/firebase_admob.dart';
import 'dart:async';

class AdMob {
  // singlton implementation
  static final instance = new AdMob._internal();
  AdMob._internal();

  static const String _AppId = "ca-app-pub-4817322293124465~6673843502";
  static const String _AdUnitId = "ca-app-pub-4817322293124465/4402903388";
  static const String _AdUnitIdTest = "ca-app-pub-3940256099942544/1033173712";

  MobileAdTargetingInfo _mobileAdTargetingInfo;
  InterstitialAd _interstitialAd;
  Timer _adTimer;

  void init() {
    FirebaseAdMob.instance.initialize(appId: _AppId);
    _createAds();
    _creatTimer();
  }

  void _createAds() {
    if (_mobileAdTargetingInfo == null) {
      _mobileAdTargetingInfo = MobileAdTargetingInfo(
        keywords: <String>['flutterio', 'beautiful apps'],
        contentUrl: 'https://flutter.io',
        childDirected: false,
        testDevices: <String>[], // Android emulators are considered test devices
      );
    }

    if (_interstitialAd != null) {
      _interstitialAd.dispose();
      _interstitialAd = null;
    }

    _interstitialAd = InterstitialAd(
      adUnitId: _AdUnitIdTest,
      targetingInfo: _mobileAdTargetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");

        if (event == MobileAdEvent.closed) {
          print('creating new ad');
          _createAds();
        } else if (event == MobileAdEvent.loaded) {
          print('ad loaded');
        }
      },
    )..load();
  }

  void _creatTimer() {
    const adInterval = const Duration(seconds: 10);
    _adTimer = new Timer.periodic(adInterval, _showAd);
  }

  void _showAd(Timer timer) async {
    print('showing ad');

    bool isLoaded = await _interstitialAd.isLoaded();
    print('loaded state = $isLoaded');
    if (!isLoaded) return;

    _interstitialAd.show();
    print('called show on the ad');
  }
}
