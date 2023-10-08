import 'package:adb_server_manager/app_globle.dart';
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
// https://projects.xcitech.in/pm2-api/
// http://192.168.29.170:8080
  @override
  void initState() {
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
    return BlocProvider(
      create: (context) => BackendListingBloc(),
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
