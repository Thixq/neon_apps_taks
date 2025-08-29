import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Reklamın durumlarını belirten bir enum
enum BannerAdStatus { initial, loading, loaded, failed }

class AdmobBanner {
  BannerAd? _bannerAd;
  final String adUnitId;

  // Reklamın durumunu takip etmek için ValueNotifier kullanıyoruz
  final ValueNotifier<BannerAdStatus> _status = ValueNotifier(
    BannerAdStatus.initial,
  );

  // Constructor
  AdmobBanner({required this.adUnitId});

  // Reklamı yükleme fonksiyonu
  void loadAd() {
    _status.value = BannerAdStatus.loading; // Yükleme durumuna geç

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _status.value = BannerAdStatus.loaded; // Reklam yüklendi
          debugPrint('BannerAd loaded.');
        },
        onAdFailedToLoad: (ad, err) {
          _status.value = BannerAdStatus.failed; // Yükleme başarısız oldu
          ad.dispose();
          debugPrint('BannerAd failed to load: $err');
        },
        onAdClicked: (ad) => debugPrint('BannerAd clicked.'),
        onAdImpression: (ad) => debugPrint('BannerAd impression occurred.'),
        onAdClosed: (ad) => debugPrint('BannerAd closed.'),
      ),
    );
    _bannerAd!.load();
  }

  // Reklamı görüntülemek için widget döndüren fonksiyon
  Widget viewBanner() {
    return ValueListenableBuilder<BannerAdStatus>(
      valueListenable: _status,
      builder: (context, status, child) {
        switch (status) {
          case BannerAdStatus.loading:
            return SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: const Center(
                child:
                    CircularProgressIndicator.adaptive(), // Yüklenirken dönen ikon
              ),
            );
          case BannerAdStatus.failed:
            return SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: const Center(
                child: Icon(Icons.error, color: Colors.red), // Hata ikonu
              ),
            );
          case BannerAdStatus.loaded:
            return SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            );
          default:
            return const SizedBox.shrink(); // Başlangıçta boş widget
        }
      },
    );
  }

  // Reklamı bellekten silme
  void dispose() {
    _bannerAd?.dispose();
    _status.dispose(); // ValueNotifier'ı da dispose et
  }
}
