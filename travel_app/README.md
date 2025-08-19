# 📌 Neon Academy Traveler App

## 📖 Senaryo

Jane ve John isimli genç bir çift, dünya turuna çıkmak için uzun zamandır hayal kurmaktadır. Yıllar boyunca biriktirdikleri parayla nihayet hayallerindeki yolculuğu planlamaya başlarlar. Ancak gitmek istedikleri yerleri unuttuklarını fark ederler.

Bunu çözmek için küçük bir mobil uygulama geliştirmeye karar verirler. Uygulama sayesinde gitmek istedikleri yerleri kaydedip daha sonra tekrar görüntüleyebilirler.

## 🎯 Görev

Bu projede amaç, **Flutter’da SharedPreferences kullanarak veri kaydetme ve geri okuma** sürecini öğrenmektir.

Uygulamada şu işlemler yapılmaktadır:

* Kullanıcıdan üç tip veri alınır:

  * **Bool** → "Bu yere daha önce gittiniz mi?"
  * **Int** → "Bu yeri kaç kez ziyaret ettiniz?"
  * **String** → "Gitmek istediğiniz yerin adı nedir?"
* Girilen veriler **SharedPreferences** içine kaydedilir.
* Uygulama kapatılıp tekrar açıldığında veriler SharedPreferences’tan okunarak ekrana yansıtılır.

## 🛠 Kullanılan Teknolojiler

* **Flutter**
* **SharedPreferences** paketi

## 📱 Özellikler

* Kullanıcı giriş alanları üzerinden değer girer.
* Kaydet butonuna basıldığında veriler cihaz hafızasına yazılır.
* Uygulama tekrar açıldığında kaydedilen bilgiler ekranda görünür.

## 🎓 Kazanımlar

Bu görev ile:

* SharedPreferences nedir ve nasıl çalışır öğrenildi.
* Bool, Int ve String tipinde verilerin kalıcı olarak saklanması uygulandı.
* Flutter’da basit bir veri saklama mekanizması deneyimlendi.