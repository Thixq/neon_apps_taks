import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/product/home/feed/feed_view_model/feed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class FeedViewModel extends Cubit<FeedState> {
  FeedViewModel({
    required ProfileManager profileManager,
    required FeedManager feedManager,
  }) : _feedManager = feedManager,
       _profileManager = profileManager,
       super(const FeedInitialState());

  final FeedManager _feedManager;
  final ProfileManager _profileManager;

  Future<void> getFeed() async {
    emit(const FeedLoadingState(posts: []));
    final posts = await _feedManager.fetchFeed(_profileManager.profile!.id);
    emit(FeedLoadedState(posts: posts));
  }
}
