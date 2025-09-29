import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:equatable/equatable.dart';

/// State for the "profile" flow
final class ProfileViewState extends Equatable {
  /// Constructor
  const ProfileViewState({required this.postsState});

  /// Posts state
  final ProfileViewPotsState postsState;

  @override
  List<Object?> get props => [postsState];

  /// copy with
  ProfileViewState copyWith({
    ProfileViewPotsState? postsState,
  }) {
    return ProfileViewState(
      postsState: postsState ?? this.postsState,
    );
  }
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
