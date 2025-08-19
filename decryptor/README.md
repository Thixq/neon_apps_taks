# 🔐 Decryption 

## 📖 Proje Özeti

Bu proje, Flutter kullanılarak geliştirilmiş bir **şifre çözme (decryption) simülasyonu**dur. Kullanıcı, gizli bir ajansın ajanı rolünde doğru kodu girerek şifrelenmiş mesajı çözmeye çalışır.

Doğru kod girildiğinde **15 saniyelik geri sayım** başlar, ardından uygulama şifre çözme işlemini tamamlar ve çözülmüş mesajı kısa süreliğine ekranda gösterir.

---

## 🎯 Uygulama Akışı

1. **Decrypt butonuna basılır.**
2. Kullanıcıdan bir **kod girmesi** istenir.
3. Kod doğru girildiyse uygulama **15 saniye geri sayım** başlatır.
4. Kullanıcı yeni bir ekrana yönlendirilir (**Bekleme ekranı**).
5. Şifre çözme işlemi tamamlandığında, uygulama bir **bildirim** gönderir.
6. Bildirim alındığında çözülmüş mesaj ekrandaki **Text widget** içinde gösterilir.
7. Mesaj yalnızca birkaç saniye görüntülenir ve sonra kaybolur.

---

## 🛠 Kullanılan Teknolojiler

* **Timer** (geri sayım için)
* **State management / ChangeNotifier**


---

## 📂 Proje Yapısı (Örnek)

```
lib/
 ├── main.dart          // Uygulama başlangıç noktası
 ├── home.dart  // Decrypt butonu ve kod girişi
 ├── result.dart  // Bekleme ekranı ve mesaj gösterimi
 └── notification_center.dart      // Bildirim / state yönetimi
```

## 🧩 Kazanımlar

Bu görev ile:

* Kullanıcıdan **girdi alma (input handling)**,
* **Timer** ile geri sayım başlatma,
* **Bildirim mantığı** ile ekranlar arası iletişim,
* Dinamik **UI güncellemeleri** yönetme
  konuları öğrenildi ve pekiştirildi.

---

👉 Bu sürüm sana uygun mu, yoksa daha da **GitHub-vitrinlik (badge’li, görselli)** bir hale getirmemi ister misin?
