part of '../home_view.dart';

class _HomeGridView extends StatelessWidget {
  const _HomeGridView({this.shows, required this.cardOnPressed});

  final List<ShowModel?>? shows;
  final ValueChanged<ShowModel?> cardOnPressed;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 9 / 16,
      ),
      itemCount: shows?.length,
      itemBuilder: (context, index) {
        final show = shows?[index];
        return Hero(
          tag: show!.id!,
          child: ShowCard(
            image: show.image ?? '',
            title: show.name ?? '',
            onPressed: () => cardOnPressed(show),
          ),
        );
      },
    );
  }
}
