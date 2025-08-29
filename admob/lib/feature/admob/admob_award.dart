import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Reklamın durumlarını belirten bir enum
enum RewardedAdStatus { initial, loading, loaded, failed, dismissed, rewarded }

class AdmobRewarded {
  RewardedAd? _rewardedAd;
  final String adUnitId;

  // Reklamın durumunu takip etmek için ValueNotifier kullanıyoruz
  final ValueNotifier<RewardedAdStatus> _status = ValueNotifier(
    RewardedAdStatus.initial,
  );

  // Constructor
  AdmobRewarded({required this.adUnitId});

  // Reklamı yükleme fonksiyonu
  void loadAd() {
    _status.value = RewardedAdStatus.loading;

    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _status.value = RewardedAdStatus.loaded;
          debugPrint('RewardedAd loaded.');
          // Tam ekran reklamlar için dinleyici ekle
          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _status.value = RewardedAdStatus.dismissed;
              debugPrint('RewardedAd dismissed.');
              ad.dispose(); // Reklamı kapatınca bellekten sil
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              _status.value = RewardedAdStatus.failed;
              debugPrint('RewardedAd failed to show: $err');
              ad.dispose(); // Hata oluşunca bellekten sil
            },
            onAdShowedFullScreenContent: (ad) {
              debugPrint('RewardedAd showed.');
            },
          );
        },
        onAdFailedToLoad: (err) {
          _status.value = RewardedAdStatus.failed;
          debugPrint('RewardedAd failed to load: $err');
        },
      ),
    );
  }

  // Reklamı gösterme ve ödül callback'i (geri çağırma) alma fonksiyonu
  void showAd({required Function onRewarded}) {
    if (_status.value == RewardedAdStatus.loaded) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint(
            'User earned a reward! Reward amount: ${reward.amount}, type: ${reward.type}',
          );
          _status.value = RewardedAdStatus.rewarded;
          onRewarded(); // Ödül verme fonksiyonunu çağır
        },
      );
    } else {
      debugPrint('RewardedAd is not ready to be shown.');
    }
  }

  // Reklamın mevcut durumunu dışarıya açar
  ValueNotifier<RewardedAdStatus> get status => _status;

  // Reklamı bellekten silme
  void dispose() {
    _rewardedAd?.dispose();
    _status.dispose();
  }
}
