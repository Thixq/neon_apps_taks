import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Reklamın durumlarını belirten bir enum
enum InterstitialAdStatus { initial, loading, loaded, failed, dismissed }

class AdmobInterstitial {
  InterstitialAd? _interstitialAd;
  final String adUnitId;

  final ValueNotifier<InterstitialAdStatus> _status = ValueNotifier(
    InterstitialAdStatus.initial,
  );

  AdmobInterstitial({required this.adUnitId});

  void loadAd() {
    _status.value = InterstitialAdStatus.loading;

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _status.value = InterstitialAdStatus.loaded;
          debugPrint('InterstitialAd loaded.');
          // Tam ekran reklamlar için dinleyici ekle
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  _status.value = InterstitialAdStatus.dismissed;
                  debugPrint('InterstitialAd dismissed.');
                  ad.dispose(); // Reklamı kapatınca bellekten sil
                },
                onAdFailedToShowFullScreenContent: (ad, err) {
                  _status.value = InterstitialAdStatus.failed;
                  debugPrint('InterstitialAd failed to show: $err');
                  ad.dispose(); // Hata oluşunca bellekten sil
                },
                onAdShowedFullScreenContent: (ad) {
                  debugPrint('InterstitialAd showed.');
                },
              );
        },
        onAdFailedToLoad: (err) {
          _status.value = InterstitialAdStatus.failed;
          debugPrint('InterstitialAd failed to load: $err');
        },
      ),
    );
  }

  void showAd() {
    if (_status.value == InterstitialAdStatus.loaded) {
      _interstitialAd!.show();
    } else {
      // Yüklü değilse yeniden yükleme veya hata mesajı
      debugPrint('InterstitialAd is not ready to be shown.');
    }
  }

  ValueNotifier<InterstitialAdStatus> get status => _status;

  void dispose() {
    _interstitialAd?.dispose();
    _status.dispose();
  }
}
