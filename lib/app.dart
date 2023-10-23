import 'package:adb_server_manager/features/firebase_notifications_service.dart';
import 'package:adb_server_manager/features/login/bloc/login_bloc.dart';
import 'package:adb_server_manager/features/logs/bloc/logs_bloc.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
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
  LoginBloc loginBloc = LoginBloc();
  LogsBloc logsBloc = LogsBloc();

  PushNotificationService pushNotificationService = PushNotificationService();
  bool? isLoggedIn;

  @override
  void initState() {
    pushNotificationService.requestNotificationPermission();
    pushNotificationService.forgroundMessage();
    pushNotificationService.firebaseInit(context);
    pushNotificationService.setupInteractMessage(context);
    pushNotificationService.isTokenRefresh(loginBloc);
    pushNotificationService.getToken(loginBloc);

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
          create: (context) => logsBloc,
        ),
        BlocProvider(
          create: (context) => loginBloc,
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
