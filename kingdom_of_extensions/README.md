# Kingdom Of Extensions

Basit bir Flutter örnek uygulaması — Dart dilindeki **extension** kullanımını göstermek amacıyla hazırlanmıştır. Uygulama farklı veri tipleri için yazılmış extension'ları kullanarak küçük interaktif sayfalar sunar.

## Özellikler

* `String` için palindrom kontrolü
* `int` için asal sayı kontrolü
* `DateTime` için iki tarih arası gün farkı hesaplama
* `bool` için basit mantıksal işlemler
* `dynamic` için try-cast (çalışma zamanı cast denemesi)
* `Set` için simetrik fark (symmetric difference)
* `List<Map<String, String>>` için soyada göre gruplama (groupBySurname)

Uygulama eğitim amaçlıdır; kod okunabilir ve kolayca genişletilebilir.

---

## Dosya Yapısı

```
└── lib/
    ├── main.dart
    ├── extensions.dart
    └── pages/
        └── int_page.dart
```

> Not: Bu repo örneğinizde sadece `int_page.dart` gösterilmiş. Orijinal demo daha fazla sayfa içeriyordu (string\_page, datetime\_page, bool\_page, dynamic\_page, set\_page, map\_page). İsterseniz onları da `pages/` altına taşıyıp dosya yapısını genişletebilirim.




