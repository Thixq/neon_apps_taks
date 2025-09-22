import 'package:clone_insta/feature/models/post_model/post_models.dart';

sealed class FeedState {
  const FeedState({required this.posts});

  final List<PopulatedPostModel> posts;
}

final class FeedInitialState extends FeedState {
  const FeedInitialState() : super(posts: const []);
}

final class FeedLoadedState extends FeedState {
  const FeedLoadedState({required super.posts});
}

final class FeedLoadingState extends FeedState {
  const FeedLoadingState({required super.posts});
}

final class FeedErrorState extends FeedState {
  const FeedErrorState({required this.error, required super.posts});

  final String error;
}
