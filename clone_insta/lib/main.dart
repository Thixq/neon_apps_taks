import 'package:clone_insta/feature/components/post_card/post_card.dart';
import 'package:clone_insta/feature/models/post_model.dart';

import 'package:clone_insta/feature/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: NeonTheme.dark(),
      theme: NeonTheme.light(),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: PostCard(
              post: PostModel.mock(),
            ),
          ),
        ),
      ),
    );
  }
}
