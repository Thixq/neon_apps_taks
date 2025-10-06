import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Veri Modeli ve DetailPage aynı kalır.
// (Burada tekrar kodlanmamıştır, önceki yanıtta mevcuttur.)

class AppModel {
  final String appName; // Uygulamanın Adı
  final String appIcon; // Uygulamanın İkonu (Emoji veya İkon Kodu)
  final String releaseDate; // Yayın Tarihi
  final String appCategory; // Uygulama Kategorisi
  final String storeURL; // Mağaza Bağlantısı (Tıklanabilir)
  bool isSelected; // isSelect gereksinimi için durum değişkeni

  AppModel({
    required this.appName,
    required this.appIcon,
    required this.releaseDate,
    required this.appCategory,
    required this.storeURL,
    this.isSelected = false, // Varsayılan olarak seçili değil
  });
}

class MarinaAppGridInListView extends StatefulWidget {
  const MarinaAppGridInListView({super.key});

  @override
  State<MarinaAppGridInListView> createState() =>
      _MarinaAppGridInListViewState();
}

class _MarinaAppGridInListViewState extends State<MarinaAppGridInListView> {
  // Örnek Veri (Apps listesi)
  List<AppModel> apps = [
    AppModel(
      appName: "Deniz Haritası",
      appIcon: "💧",
      releaseDate: "01.01.2025",
      appCategory: "Eğitim",
      storeURL: "https://example.com/map",
    ),
    AppModel(
      appName: "Kuyruk Takip",
      appIcon: "🧜‍♀️",
      releaseDate: "15.02.2025",
      appCategory: "Araçlar",
      storeURL: "https://example.com/track",
    ),
    AppModel(
      appName: "Yosun Tarifleri",
      appIcon: "🌿",
      releaseDate: "10.03.2025",
      appCategory: "Yaşam Tarzı",
      storeURL: "https://example.com/recipes",
    ),
    // ... Daha fazla uygulama
  ];

  double itemAspectRatio = 1.0; // sizeForItem ayarı

  // Pull to Refresh Fonksiyonu
  Future<void> _refreshApps() async {
    await Future.delayed(const Duration(seconds: 2));
    // Yeni veri çekme mantığı buraya gelir.
    setState(() {}); // UI'yı güncelle
  }

  void _toggleSelection(int index) {
    setState(() {
      apps[index].isSelected = !apps[index].isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Pull to Refresh özelliği, tüm kaydırma alanını sarmalar
      body: RefreshIndicator(
        onRefresh: _refreshApps,
        // ListView/GridView yerine CustomScrollView kullanılır
        child: CustomScrollView(
          slivers: <Widget>[
            // sizeForItem özelliği için üstte bir ayar çubuğu ekleyelim (SliverToBoxAdapter ile)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Grid Öğe Boyutu:"),
                    Expanded(
                      child: Slider(
                        value: itemAspectRatio,
                        min: 0.5,
                        max: 2.0,
                        onChanged: (double value) {
                          setState(() {
                            itemAspectRatio = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Grid View içeriği, artık bir SliverGrid
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Her satırda iki öğe
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: itemAspectRatio, // sizeForItem ayarı
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final app = apps[index];

                // cupertinoContextMenu özelliği ve item'a tıklama (GestureDetector)
                return CupertinoContextMenu(
                  actions: <Widget>[
                    CupertinoContextMenuAction(
                      child: const Text('Paylaş'),
                      onPressed: () {
                        Navigator.pop(context); // Menüyü kapat
                        // Paylaşma mantığı
                      },
                    ),
                  ],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(app: app),
                        ),
                      );
                    },
                    child: AppGridItem(
                      app: app,
                      onSelectToggle: () => _toggleSelection(index),
                    ),
                  ),
                );
              }, childCount: apps.length),
            ),

            // CustomScrollView'e ListView gibi ek içerik eklemek için SliverToBoxAdapter kullanılabilir
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Toplam ${apps.length} uygulama listeleniyor.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// 2. APP GRID ITEM WIDGET'I
// ==========================================================

class AppGridItem extends StatelessWidget {
  final AppModel app;
  final VoidCallback onSelectToggle; // isSelect durumu değişimi için callback

  const AppGridItem({
    required this.app,
    required this.onSelectToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: app.isSelected
          ? Colors.lightBlue.shade50
          : Colors.white, // isSelect görseli
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(app.appIcon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              app.appName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          // isSelect özelliği görselleştirme
          IconButton(
            icon: Icon(
              app.isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: Colors.blue,
              size: 20,
            ),
            onPressed:
                onSelectToggle, // Tıklandığında ana sınıftaki durumu değiştirir
            tooltip: app.isSelected ? 'Seçimi Kaldır' : 'Seç',
          ),
        ],
      ),
    );
  }
}
// ==========================================================
// 3. DETAY SAYFASI WIDGET'I
// ==========================================================

class DetailPage extends StatelessWidget {
  final AppModel app;

  const DetailPage({required this.app, super.key});

  // // URL açma fonksiyonu (url_launcher paketi gerektirir)
  // void _launchAppStore(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     // Hata mesajı gösterilebilir
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.appName),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(app.appIcon, style: const TextStyle(fontSize: 80)),
            ),
            const Divider(),
            _buildDetailRow('Uygulama Adı', app.appName),
            _buildDetailRow('Kategori', app.appCategory),
            _buildDetailRow('Yayın Tarihi', app.releaseDate),
            const SizedBox(height: 20),
            // storeURL'ye tıklama özelliği
            TextButton.icon(
              icon: const Icon(Icons.store, color: Colors.blue),
              label: Text(
                app.storeURL,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                // _launchAppStore(app.storeURL);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${app.storeURL} adresine gidiliyor...'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tekrarlanan detay satırlarını oluşturan yardımcı metot
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
