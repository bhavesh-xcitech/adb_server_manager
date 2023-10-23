import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppGlobals {
  static final AppGlobals _singleton = AppGlobals._internal();

  factory AppGlobals() {
    return _singleton;
  }

  AppGlobals._internal();
  io.Socket socket = io.io(dotenv.env['SOCKET_URL'] ?? '', <String, dynamic>{
    'transports': ['websocket'], // Use WebSocket transport
    'force new connection': true,
  });
  // Add properties to store your global data
}
