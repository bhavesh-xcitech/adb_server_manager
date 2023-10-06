import 'package:adb_server_manager/app.dart';
import 'package:adb_server_manager/app_globle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');

  void connectAndListen() {
    print("function callled ");
    var socket = io.io("https://projects.xcitech.in", <String, dynamic>{
      'transports': ['websocket'], // Use WebSocket transport
      // 'autoConnect': false,
      // 'query': 'EIO=4&transport=polling',
      // 'forceNew': true,
    });
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('connect', (_) {
      print("i amm callleddd");
      socket.emit('start-logs');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('pm2-log', (data) {
      print(data);

      AppGlobals().streamSocket.addResponse(data);
    });
    socket.on('pm2-log-error',
        (data) => AppGlobals().streamSocket.addResponse(data));
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
    socket.onDisconnect((_) => print('disconnect'));
  }

  connectAndListen();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}
