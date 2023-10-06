import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
import 'package:adb_server_manager/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MyApp extends StatefulWidget {
  const MyApp({super.key, });

  @override
  State<MyApp> createState() => _MyAppState();
}

late io.Socket socket;

class _MyAppState extends State<MyApp> {
  final logTextController = TextEditingController();
  BackendListingBloc backendListingBloc = BackendListingBloc();
// https://projects.xcitech.in/pm2-api/
// http://192.168.29.170:8080
  @override
  void initState() {
    // backendListingBloc.add(ConnectingToSocket());
    // socket = io.io(dotenv.env['LOCAL_URL'], <String, dynamic>{
    //   'transports': ['websocket'], // Use WebSocket transport
    //   // 'autoConnect': false,
    //   // 'query': 'EIO=4&transport=polling',
    //   // 'forceNew': true,
    // });

    // socket.connect();
    // socket.onConnect((_) {
    //   print('Connection established');
    // });
    // socket.onError((error) {
    //   print('Socket.IO Error: $error');
    // });
    // print("soket connected ");
    // // Listen for socket events
    // socket.on('pm2-log', (data) {
    //   print(data);
    //   // print("lalalaalalla");
    //   setState(() {
    //     logTextController.text += data + '\n'; // Update log messages in your UI
    //   });
    // });

    // socket.on('pm2-log-error', (data) {
    //   print("pm2 errrorrr is called");
    //   setState(() {
    //     logTextController.text +=
    //         data + '\n'; // Update error messages in your UI
    //   });
    // });

    // // Start sending logs when connected
    // socket.on('connect', (_) {
    //   print("i amm callleddd");
    //   socket.emit('start-logs');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => backendListingBloc,
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
