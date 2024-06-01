import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiService {
  final IO.Socket socket;

  ApiService({
    required this.socket,
  });

  static Future<bool> sendCarNum(String carNum, IO.Socket socket) async {
    late dynamic result;

    socket.emitWithAck('enter', jsonEncode({'carNum': carNum}), ack: (data) {
      result = data;
    });

    final json = jsonDecode(result);

    if (json['paymentId']) {
      return true;
    } else {
      return false;
    }
  }
}
