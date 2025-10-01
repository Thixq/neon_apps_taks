import 'package:flutter/material.dart';
import '../core/dio_client.dart';
import '../model/post.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<List<Post>> fetchPosts() async {
    final response = await DioClient().dio.get("posts");
    final List data = response.data;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dio Interceptor Example")),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Veri yok"));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
      ),
    );
  }
}
