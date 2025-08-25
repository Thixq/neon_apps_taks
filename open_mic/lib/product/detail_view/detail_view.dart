import 'package:flutter/material.dart';
import 'package:open_mic/feature/model/show_model.dart';

part './widgets/detail_view_image_card.dart';
part './widgets/detail_ticker_counter.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late final ShowModel? show;

  @override
  void didChangeDependencies() {
    show = ModalRoute.of(context)?.settings.arguments as ShowModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(show?.name ?? 'title')),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: show!.id!,
                  child: _DetailViewImageCard(imagePath: show?.image),
                ),
              ),
              Expanded(
                flex: 6,
                child: SafeArea(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        show!.desc! * 12,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      _DetailTickerCounter((value) {}),
                      Expanded(child: SizedBox.expand()),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          minimumSize: Size.fromHeight(0),
                        ),
                        onPressed: () {},
                        child: Text('Bilet Al'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
