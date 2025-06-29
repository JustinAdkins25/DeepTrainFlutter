import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketChannel = WebSocketChannel.connect(
  Uri.parse('wss://api.deeptrain.umgc.edu/v1/stream'),
);
