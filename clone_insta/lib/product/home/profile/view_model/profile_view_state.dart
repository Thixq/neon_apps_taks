// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:equatable/equatable.dart';

final class ProfileViewState extends Equatable {
  const ProfileViewState({required this.postsState});

  final ProfileViewPotsState postsState;

  @override
  List<Object?> get props => [postsState];

  ProfileViewState copyWith({
    ProfileViewPotsState? postsState,
  }) {
    return ProfileViewState(
      postsState: postsState ?? this.postsState,
    );
  }
}

sealed class ProfileViewPotsState extends Equatable {
  const ProfileViewPotsState();

  @override
  List<Object?> get props => [];
}

final class ProfileViewPostStateInitial extends ProfileViewPotsState {
  const ProfileViewPostStateInitial();
}

final class ProfileViewPostStateLoading extends ProfileViewPotsState {
  const ProfileViewPostStateLoading();
}

final class ProfileViewPostStateLoaded extends ProfileViewPotsState {
  const ProfileViewPostStateLoaded({
    this.posts,
  });

  /// fetch posts
  final List<PopulatedPostModel?>? posts;

  @override
  List<Object?> get props => [posts];
}

final class ProfileViewPostStateError extends ProfileViewPotsState {
  const ProfileViewPostStateError({required this.errorMessage});
  final String errorMessage;
}
