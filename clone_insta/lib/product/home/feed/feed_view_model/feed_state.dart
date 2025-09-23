import 'package:clone_insta/feature/models/post_model/post_models.dart';

/// The state of the feed
sealed class FeedState {
  const FeedState({required this.posts});

  /// The list of posts
  final List<PopulatedPostModel> posts;
}

/// The initial state
final class FeedInitialState extends FeedState {
  /// The initial state
  const FeedInitialState() : super(posts: const []);
}

/// The state when the feed is loaded
final class FeedLoadedState extends FeedState {
  /// The state when the feed is loaded
  const FeedLoadedState({required super.posts});
}

/// The state when the feed is loading
final class FeedLoadingState extends FeedState {
  /// The state when the feed is loading
  const FeedLoadingState({required super.posts});
}

/// The state when the feed has an error
final class FeedErrorState extends FeedState {
  /// The state when the feed has an error
  const FeedErrorState({required this.error, required super.posts});

  /// The error
  final String error;
}
