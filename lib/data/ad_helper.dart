import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../const/strings.dart';

class AdHelper {
  static bool isTestMode = true;

  static String get bannerAdUnitId {
    if (isTestMode) {
      return bannerAdUnitIdString;
    } else {
      return 'add_real_here';
    }
  }

  static String get interstitialAdUnitId {
    if (isTestMode) {
      return interstitialAdUnitIdString;
    } else {
      return 'add_real_here';
    }
  }

  static String get rewardedAdUnitId {
    if (isTestMode) {
      return rewardedAdUnitIdString;
    } else {
      return 'add_real_here';
    }
  }
}

class InterstitialAdFunc {
  static InterstitialAd? interstitialAd;
  static bool isLoad = false;

  static load() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          isLoad = true;
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static void show() {
    if (isLoad) {
      interstitialAd!.show();
    }
  }
}

class RewardedAdUnitFunc {
  static RewardedAd? rewardedAd;
  static bool isLoad = false;

  static void load() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          isLoad = true;
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  static void show() {
    if (isLoad) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {},
      );
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('dessmise add ============================');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
    );
  }
}
