import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiService {
  final IO.Socket socket;

  ApiService({
    required this.socket,
  });

  static Future<bool> sendCarNum(String carNum, IO.Socket socket) async {
    final completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('enter', jsonEncode({'carNum': carNum}), ack: (data) {
      completer.complete(data);
    });

    Map<String, dynamic> result = await completer.future;

    print('$result');
    if (result.containsKey('paymentId')) {
      return true;
    } else {
      return false;
    }
  }
}
