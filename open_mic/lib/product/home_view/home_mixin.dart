part of 'home_view.dart';

mixin _HomeMixin on State<HomeView> {
  late final HomeViewModel viewModel;
  void _goDetial(ShowModel? show) {
    Navigator.pushNamed(context, '/detail', arguments: show);
  }

  @override
  void initState() {
    viewModel = context.read<HomeViewModel>();
    viewModel.getShows();
    super.initState();
  }
}
