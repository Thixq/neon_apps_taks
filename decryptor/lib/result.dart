import 'package:decryptor/notification_center.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
