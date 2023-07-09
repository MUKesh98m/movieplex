import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends ChangeNotifier {
  bool showAd = false;

  List<String> movieList = [
    'hdhub4u',
    'yomovies',
    'desiremovies',
    'm.vegamovies',
    'katmoviehd',
    'moviesverse',
  ];
  List<String> movieImage = [
    'asset/img1.png',
    'asset/img2.png',
    'asset/img3.png',
    'asset/img4.png',
    'asset/img5.png',
    'asset/img6.jpg',
  ];
  List<String> movieLink = [
    'https://hdhub4u.faith',
    'https://yomovies.team/',
    'https://desiremovies.training/',
    'https://m.vegamovies.tips/',
    'https://katmoviehd.ma/',
    'https://moviesverse.bet/',
  ];

  WebViewController? controller;
  late AppOpenAd appOpenAd;
  final String _appOpenAdUnitId = AppString.openAd; // Testing Ad Unit ID
  bool isAdLoaded = false;
  late BannerAd ad;

  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: _appOpenAdUnitId,
      request: const AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          showAppOpenAd();
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void showAppOpenAd() async {
    await appOpenAd.show();
  }

  void loadAd() {
    ad = BannerAd(
      adUnitId: AppString.bannerAd,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print("Banner Ad is Loaded Succesfully");
          isAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {},
      ),
    );
    ad.load();
  }
}
