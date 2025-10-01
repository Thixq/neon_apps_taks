import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

/// Barbie & Ken hikayesi için basit FutureBuilder örneği.
/// Burada API'den veri çekip ListTile ile ekrana yazdırıyoruz.
/// API = Sunucu, Uygulama = İstemci (yani Barbie & Ken arasındaki köprü).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarbieKenPage(),
    );
  }
}

class BarbieKenPage extends StatelessWidget {
  const BarbieKenPage({super.key});

  /// API'den veri çekme fonksiyonu
  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Veri alınamadı!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barbie & Ken API Demo"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          // Yükleniyor
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Hata durumu
          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }

          // Veri geldiğinde
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Text(post['id'].toString()),
                  ),
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                );
              },
            );
          }

          // Hiç veri gelmezse
          return const Center(child: Text("Veri bulunamadı"));
        },
      ),
    );
  }
}
