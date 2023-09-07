import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_download_from_internet/data/service/notifications.dart';
import 'package:file_download_from_internet/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'download_channel',
        channelName: 'Download Channel',
        channelDescription: 'Notifications for downloads',
        importance: NotificationImportance.Low,
        defaultColor: Colors.blue,
        ledColor: Colors.blue,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
