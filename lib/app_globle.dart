import 'dart:async';

class AppGlobals {
  static final AppGlobals _singleton = AppGlobals._internal();

  factory AppGlobals() {
    return _singleton;
  }

  AppGlobals._internal();

  // Add properties to store your global data
  StreamSocket streamSocket = StreamSocket();
}

class StreamSocket {
  final StreamController _socketResponse = StreamController.broadcast();

  Stream getResponse() {
    return _socketResponse.stream;
  }

  void addResponse(data) {
    _socketResponse.sink.add(data);
  }
void addError(error) {
  _socketResponse.sink.addError(error);
}

  void dispose() {
    _socketResponse.close();
  }
}
