import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/theme/app_theme.dart';

/// Handles: Banner, Interstitial, Rewarded, App Open Ads
class AdsService {
  AdsService._();
  static final AdsService instance = AdsService._();

  // ── AdMob App ID (must match AndroidManifest APPLICATION_ID & iOS GADApplicationIdentifier) ──
  static const String prodAppId = 'ca-app-pub-4424067808361380~6187859775';
  static const String testAppId = 'ca-app-pub-3940256099942544~3347511713';

  static String get appId => kDebugMode ? testAppId : prodAppId;

  // ── Ad Unit IDs ──────────────────────────────────────────────────────────
  // Replace with your real Ad Unit IDs from AdMob console: TODO
  // Test IDs are used automatically in debug mode.

  static String get _bannerId => kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111' // test
      : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // production

  static String get _interstitialId => kDebugMode
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

  static String get _rewardedId => kDebugMode
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

  static String get _appOpenId => kDebugMode
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-4424067808361380/7603367856';

  static const String _prodNativeAdvancedId =
      'ca-app-pub-4424067808361380/2542612867';

  static String get nativeAdvancedAdUnitId {
    if (kDebugMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/3986624511';
      }
      return 'ca-app-pub-3940256099942544/2247696110';
    }
    return _prodNativeAdvancedId;
  }

  static NativeTemplateStyle get nativeTemplateStyle => NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: AppColors.bgMid,
        cornerRadius: 12.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textOnCta,
          backgroundColor: AppColors.starBlue,
          style: NativeTemplateFontStyle.bold,
          size: 14.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textPrimary,
          style: NativeTemplateFontStyle.bold,
          size: 14.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textSub,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.textSub,
          style: NativeTemplateFontStyle.normal,
          size: 11.0,
        ),
      );

  // ── Internal State ───────────────────────────────────────────────────────
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  bool _isInterstitialReady = false;
  bool _isRewardedReady = false;
  bool _isAppOpenReady = false;
  bool _isLoadingAppOpen = false;
  bool _isShowingAppOpenAd = false;
  bool _coldStartComplete = false;
  bool _hasShownAppOpenAd = false;

  // ── Initialize ───────────────────────────────────────────────────────────
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    _loadInterstitial();
    _loadRewarded();
    _loadAppOpenAd();
  }

  // ── Banner Ad ────────────────────────────────────────────────────────────
  Future<BannerAd> loadBannerAd() async {
    _bannerAd = BannerAd(
      adUnitId: _bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => debugPrint('✅ Banner loaded'),
        onAdFailedToLoad: (ad, err) {
          debugPrint('❌ Banner failed: $err');
          ad.dispose();
        },
      ),
    );
    await _bannerAd!.load();
    return _bannerAd!;
  }

  BannerAd? get bannerAd => _bannerAd;

  // ── Interstitial Ad ──────────────────────────────────────────────────────
  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: _interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialReady = true;
          debugPrint('✅ Interstitial loaded');
        },
        onAdFailedToLoad: (err) {
          _isInterstitialReady = false;
          debugPrint('❌ Interstitial failed: $err');
        },
      ),
    );
  }

  void showInterstitial() {
    if (_isInterstitialReady && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isInterstitialReady = false;
          _loadInterstitial(); // preload next
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _loadInterstitial();
        },
      );
      _interstitialAd!.show();
    }
  }

  // ── Rewarded Ad ──────────────────────────────────────────────────────────
  void _loadRewarded() {
    RewardedAd.load(
      adUnitId: _rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedReady = true;
          debugPrint('✅ Rewarded loaded');
        },
        onAdFailedToLoad: (err) {
          _isRewardedReady = false;
          debugPrint('❌ Rewarded failed: $err');
        },
      ),
    );
  }

  void showRewarded(
      {required void Function(AdWithoutView, RewardItem) onRewarded}) {
    if (_isRewardedReady && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isRewardedReady = false;
          _loadRewarded();
        },
      );
      _rewardedAd!.show(onUserEarnedReward: onRewarded);
    }
  }

  // ── App Open Ad (cold start via SplashView) ───────────────────────────────
  bool get isAppOpenAdAvailable => _appOpenAd != null && _isAppOpenReady;

  bool get isShowingAppOpenAd => _isShowingAppOpenAd;

  bool get isColdStartComplete => _coldStartComplete;

  bool get hasShownAppOpenAd => _hasShownAppOpenAd;

  /// Splash waits for the first app open ad (or [timeout]).
  Future<void> waitForAppOpenAd({
    Duration timeout = const Duration(seconds: 8),
  }) async {
    if (isAppOpenAdAvailable) return;

    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      if (isAppOpenAdAvailable) return;
      if (!_isLoadingAppOpen && !isAppOpenAdAvailable) return;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Shown once per app session from [SplashView] on cold start.
  Future<void> showAppOpenAdOnColdStart() async {
    if (_hasShownAppOpenAd || !isAppOpenAdAvailable || _isShowingAppOpenAd) {
      return;
    }

    _hasShownAppOpenAd = true;

    final dismissed = Completer<void>();
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => _isShowingAppOpenAd = true,
      onAdDismissedFullScreenContent: (ad) {
        _onAppOpenAdClosed(ad);
        if (!dismissed.isCompleted) dismissed.complete();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        debugPrint('App open ad show failed: $err');
        _onAppOpenAdClosed(ad);
        if (!dismissed.isCompleted) dismissed.complete();
      },
    );

    await _appOpenAd!.show();
    await dismissed.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {},
    );
  }

  void markColdStartComplete() {
    _coldStartComplete = true;
  }

  void _loadAppOpenAd() {
    if (_isLoadingAppOpen) return;
    _isLoadingAppOpen = true;
    _isAppOpenReady = false;

    AppOpenAd.load(
      adUnitId: _appOpenId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAppOpenReady = true;
          _isLoadingAppOpen = false;
          debugPrint('App open ad loaded');
        },
        onAdFailedToLoad: (err) {
          _appOpenAd = null;
          _isAppOpenReady = false;
          _isLoadingAppOpen = false;
          debugPrint('App open ad failed: $err');
        },
      ),
    );
  }

  void _onAppOpenAdClosed(Ad ad) {
    _isShowingAppOpenAd = false;
    ad.dispose();
    _appOpenAd = null;
    _isAppOpenReady = false;
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _appOpenAd?.dispose();
    _appOpenAd = null;
    _isAppOpenReady = false;
  }
}
