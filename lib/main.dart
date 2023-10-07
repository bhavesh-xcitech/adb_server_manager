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
    var socket = io.io(dotenv.env['SOCKET_URL'] ?? '', <String, dynamic>{
      'transports': ['websocket'], // Use WebSocket transport
    });
    socket.onConnect((_) {
      socket.emit('msg', 'test');
    });
    socket.on('connect', (_) {
      socket.emit('start-logs');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('pm2-log', (data) {
      print(data);

      AppGlobals().streamSocket.addResponse(data);
    });
    socket.on(
        'pm2-log-error', (data) => AppGlobals().streamSocket.addResponse(data));

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
