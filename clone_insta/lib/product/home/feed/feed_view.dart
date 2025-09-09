import 'package:auto_route/annotations.dart';
import 'package:clone_insta/feature/components/post_card/post_card.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:flutter/material.dart';

part 'feed_mixin.dart';
part 'widget/feed_contents.dart';

@RoutePage()
/// FeedView
class FeedView extends StatefulWidget {
  /// FeedView
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with _FeedMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Neon Academy Social'),
      ),
      body: const _FeedContents(),
    );
  }
}
