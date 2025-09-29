import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:equatable/equatable.dart';

/// State for the "profile" flow
final class ProfileViewState extends Equatable {
  /// Constructor
  const ProfileViewState({
    required this.postsState,
    required this.profileState,
  });

  /// Posts state
  final ProfileViewPotsState postsState;

  /// Profile state
  final ProfileViewContentState profileState;

  @override
  List<Object?> get props => [postsState, profileState];

  /// copy with
  ProfileViewState copyWith({
    ProfileViewPotsState? postsState,
    ProfileViewContentState? profileState,
  }) {
    return ProfileViewState(
      postsState: postsState ?? this.postsState,
      profileState: profileState ?? this.profileState,
    );
  }
}

/// Profile info state
sealed class ProfileViewContentState extends Equatable {
  /// Constructor
  const ProfileViewContentState();

  @override
  List<Object?> get props => [];
}

/// Initial state
final class ProfileViewContentStateInitial extends ProfileViewContentState {
  /// Constructor
  const ProfileViewContentStateInitial();
}

/// Loading state
final class ProfileViewContentStateLoading extends ProfileViewContentState {
  /// Constructor
  const ProfileViewContentStateLoading();
}

/// Loaded state
final class ProfileViewContentStateLoaded extends ProfileViewContentState {
  /// Constructor
  const ProfileViewContentStateLoaded({
    required this.followers,
    required this.following,
  });

  final int followers;
  final int following;

  @override
  List<Object?> get props => [...super.props, followers, following];
}

/// Error state
final class ProfileViewContentStateError extends ProfileViewContentState {
  /// Constructor
  const ProfileViewContentStateError({required this.errorMessage});

  /// Error message
  final String errorMessage;
}

/// Posts state
sealed class ProfileViewPotsState extends Equatable {
  /// Constructor
  const ProfileViewPotsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
final class ProfileViewPostStateInitial extends ProfileViewPotsState {
  /// Constructor
  const ProfileViewPostStateInitial();
}

/// Loading state
final class ProfileViewPostStateLoading extends ProfileViewPotsState {
  /// Constructor
  const ProfileViewPostStateLoading();
}

/// Loaded state
final class ProfileViewPostStateLoaded extends ProfileViewPotsState {
  /// Constructor
  const ProfileViewPostStateLoaded({
    this.posts,
  });

  /// fetch posts
  final List<PopulatedPostModel?>? posts;

  @override
  List<Object?> get props => [posts];
}

/// Error state
final class ProfileViewPostStateError extends ProfileViewPotsState {
  /// Constructor
  const ProfileViewPostStateError({required this.errorMessage});

  /// Error message
  final String errorMessage;
}
