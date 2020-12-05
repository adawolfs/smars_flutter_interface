import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket {
  final WebSocketChannel channel;
  const WebSocket({@required this.channel});

  void sendMessage(message) {
    this.channel.sink.add(message);
  }
}
