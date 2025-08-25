import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mic/feature/model/show_model.dart';
import 'package:open_mic/feature/service/mock_network.dart';
import 'package:open_mic/feature/utils/enums/show_category.dart';
import 'package:open_mic/product/home_view/view_model/home_view_state.dart';

final class HomeViewModel extends Cubit<HomeViewState> {
  HomeViewModel({required MockNetwork mockNetwork})
    : _mockNetwork = mockNetwork,
      super(Inital(shows: [], filtered: []));
  final MockNetwork _mockNetwork;

  void getShows() async {
    emit(Loading());
    final List<ShowModel?> shows = [];
    final url = 'https://neonacademy/shows';
    for (var i = 0; i < 20; i++) {
      final response = await _mockNetwork.get<ShowModel>(
        url: url,
        castModel: ShowModel(),
      );

      shows.add(response);
    }
    emit(Succesed(shows: shows, filtered: []));
  }

  void filter(ShowCategory? category) {
    if (state is Succesed) {
      final filtered = state.shows
          ?.where((element) => element?.category == category)
          .toList();

      emit(Succesed(shows: state.shows, filtered: filtered));
    }
  }
}
