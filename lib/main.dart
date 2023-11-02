import 'package:adb_server_manager/app.dart';
import 'package:adb_server_manager/features/firebase_notifications_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// to handel background notification
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AudioPlayer().play(AssetSource('notification.mp3'));

  // AlarmPlayer alarmPlayer = AlarmPlayer();

  print(message);
  final String? msgTitle = message.notification!.title;
  final String? msgBody = message.notification!.body;
  if (msgTitle != null && msgBody != null) {
    print("Handling a background message: ${message.messageId}");
    print("onBackgroundMessage $message");
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();

  print('-- main: Firebase.initializeApp');

  PushNotificationService().requestNotificationPermission();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// For handling notification when the app is in terminated state
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  FlutterNativeSplash.remove();
}
