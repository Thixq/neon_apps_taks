import 'package:open_mic/feature/model/show_model.dart';

sealed class HomeViewState {
  const HomeViewState({this.filtered, this.shows});

  final List<ShowModel?>? shows;
  final List<ShowModel?>? filtered;
}

final class Inital extends HomeViewState {
  const Inital({super.shows, super.filtered});
}

final class Succesed extends HomeViewState {
  const Succesed({super.shows, super.filtered});
}

final class Failed extends HomeViewState {
  const Failed({super.shows, required this.errorMessage});
  final String errorMessage;
}

final class Loading extends HomeViewState {
  const Loading({super.shows});
}
