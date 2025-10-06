import 'package:flutter/material.dart';

// (Yukarıdaki ArticleModel ve newsArticles listesi bu dosyanın üstünde tanımlanmalı)

class ArticleModel {
  final String title;
  final String description;
  final String imageUrl;

  ArticleModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

// 50 adet sahte makale oluşturur (ListView.builder'ın verimliliğini göstermek için)
final List<ArticleModel> newsArticles = List.generate(
  50,
  (index) => ArticleModel(
    title: 'Denizin Derinliklerinden Gelen Haber #${index + 1}',
    description: index.isEven
        ? 'Marina\'nın kuyruğunun bulunmasıyla ilgili en son gelişmeler ve müthiş Flutter geliştiricilerinin başarısı.'
        : 'Okyanus Kraliçesi\'nin yeni gizemli planları. Detaylar içeride!',
    imageUrl: index % 3 == 0
        ? 'https://picsum.photos/id/237/200/300'
        : 'https://picsum.photos/id/${12 + index}/200/300',
  ),
);

class NewsFeedListView extends StatelessWidget {
  const NewsFeedListView({super.key});

  @override
  Widget build(BuildContext context) {
    // ListView.builder, yüzlerce öğe olsa bile sadece görünenleri render ederek
    // performansı optimize eder. Sarah'nın keşfettiği büyülü güç budur.
    return ListView.builder(
      // ListView bir Column'un veya başka bir kaydırılabilir widget'ın
      // içine yerleştirildiğinde, kendi kaydırma davranışını devre dışı bırakmak gerekir.
      // WidgetCard'ın içindeki kısıtlı alana sığması için önemlidir.
      itemCount: newsArticles.length,

      itemBuilder: (context, index) {
        final article = newsArticles[index];

        // Her bir makale için Card widget'ını kullanıyoruz.
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thumbnail (Küçük Resim)
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    // Sahte bir resim yüklemek için Image.network kullanılır.
                    child: Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      // Yüklenirken gösterilecek bir placeholder
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),

                // 2. Başlık ve Açıklama
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        article.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Makale No: ${index + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
