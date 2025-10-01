import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PostsPage());
  }
}

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

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
      appBar: AppBar(title: const Text("Gotham News")),
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
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                  leading: CircleAvatar(child: Text(post['id'].toString())),
                );
              },
            );
          }

          // Default boş durum
          return const Center(child: Text("Veri bulunamadı"));
        },
      ),
    );
  }
}
