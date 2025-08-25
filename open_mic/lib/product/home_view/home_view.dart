import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mic/feature/components/filter_widget/filter_model.dart';
import 'package:open_mic/feature/components/filter_widget/filter_widget.dart';
import 'package:open_mic/feature/components/show_card.dart';
import 'package:open_mic/feature/model/show_model.dart';
import 'package:open_mic/feature/utils/enums/show_category.dart';
import 'package:open_mic/product/home_view/view_model/home_view_model.dart';
import 'package:open_mic/product/home_view/view_model/home_view_state.dart';

part 'home_mixin.dart';
part './widgets/home_app_bar.dart';
part './widgets/home_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with _HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _HomeAppBar(
        onSeleced: (value) {
          viewModel.filter(value);
        },
      ),
      body: _buildBody(),
    );
  }

  BlocBuilder<HomeViewModel, HomeViewState> _buildBody() {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is Failed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is Succesed) {
          return _HomeGridView(
            shows: state.filtered!.isNotEmpty ? state.filtered : state.shows,
            cardOnPressed: _goDetial,
          );
        }
        return Center(child: Text('Fatat ERROR!'));
      },
    );
  }
}
