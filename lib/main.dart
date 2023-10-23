import 'package:adb_server_manager/app.dart';
import 'package:adb_server_manager/features/firebase_notifications_service.dart';
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
  // try {
  // return Future.value();
  //   print("hahahhahahhah${Firebase.apps.isEmpty}");
  //   if (Firebase.apps.isEmpty) {
  //     print("in the paragama");
  //     // Firebase is not initialized, so initialize it
  //     // await Firebase.initializeApp();
  //   }

  //   // Handle the background message
  //   // ...
  // } catch (e) {
  //   // Handle any errors
  //   print('Error in background message handler: $e');
  // }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  print('-- main: Firebase.initializeApp');

  PushNotificationService().requestNotificationPermission();

  // PushNotificationService().initialize();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// For handling notification when the app is in terminated state

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
      dataTitle: initialMessage.data['title'],
      dataBody: initialMessage.data['body'],
    );
  }
  print('-- main: initialMessage');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  FlutterNativeSplash.remove();
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}
