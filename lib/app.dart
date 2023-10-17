import 'package:adb_server_manager/app_globle.dart';
import 'package:adb_server_manager/features/firebase_notifications_service.dart';
import 'package:adb_server_manager/features/notifications/bloc/notifications_bloc.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
import 'package:adb_server_manager/resource/shared_pref.dart';
import 'package:adb_server_manager/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

late io.Socket socket;

class _MyAppState extends State<MyApp> {
  final logTextController = TextEditingController();
  NotificationsBloc notificationsBloc = NotificationsBloc();
  PushNotificationService pushNotificationService = PushNotificationService();
  bool? isLoggedIn;
// https://projects.xcitech.in/pm2-api/
// http://192.168.29.170:8080
  @override
  void initState() {
    pushNotificationService.requestNotificationPermission();
    pushNotificationService.forgroundMessage();
    pushNotificationService.firebaseInit(context);
    pushNotificationService.setupInteractMessage(context);
    pushNotificationService.isTokenRefresh(notificationsBloc);
    pushNotificationService.getToken(notificationsBloc);

    var socket = AppGlobals().socket;
    socket.onConnect((_) {
      socket.emit('msg', 'test');
    });
    socket.onDisconnect((data) => print(" i amm disconnectinngggs"));
    socket.on('connect', (_) {
      socket.emit('start-logs');
    });

    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BackendListingBloc(),
        ),
        BlocProvider(
          create: (context) => notificationsBloc,
        ),
      ],
      child: MaterialApp.router(
        title: "ADB Server Manager",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter().router,
      ),
    );
    //  MaterialApp(
    //   title: 'Flutter Demo',
    //   theme:
    //   home: const ServerListingScreen(),
    // );
  }
}
