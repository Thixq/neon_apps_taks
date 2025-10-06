import 'package:decryptor/notification_center.dart';
import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late final NotificationCenter notification;
  @override
  void initState() {
    notification = NotificationCenter();
    notification.startDecoding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: notification,
          builder: (context, child) {
            if (notification.progressed) {
              return Text('NEON ACADEMY');
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(),
                Text('${notification.progress}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
