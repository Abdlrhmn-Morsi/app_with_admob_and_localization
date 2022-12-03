import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/ad_helper.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  bool isLoad = false;
  BannerAd? bannerAd;
  final AdSize addSize = AdSize.largeBanner;

  void createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: addSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => isLoad = true),
        onAdFailedToLoad: (ad, error) =>
            log('error faild to load : ${error.message}'),
      ),
    );
    bannerAd!.load();
  }

  @override
  void initState() {
    createBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? SizedBox(
            width: addSize.width.toDouble(),
            height: addSize.height.toDouble(),
            child: AdWidget(ad: bannerAd!),
          )
        : Container();
  }
}
