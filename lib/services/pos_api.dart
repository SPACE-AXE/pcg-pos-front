import 'dart:async';
import 'package:pcg_pos/car_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiService {
  final IO.Socket socket;

  ApiService({
    required this.socket,
  });

  static Future<bool> sendCarNum(String carNum, IO.Socket socket) async {
    final completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('enter', {'carNum': carNum}, ack: (data) {
      completer.complete(data);
    });

    Map<String, dynamic> result = await completer.future;

    if (result.containsKey('paymentId')) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkParking(String carNum, IO.Socket socket) async {
    final completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('exit', {'carNum': carNum}, ack: (data) {
      completer.complete(data);
    });

    Map<String, dynamic> result = await completer.future;

    if (result['statusCode'] == 403) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> outParking(String carNum, IO.Socket socket) async {
    final completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('exit', {'carNum': carNum}, ack: (data) {
      completer.complete(data);
    });

    Map<String, dynamic> result = await completer.future;
    print(result);

    if (result.containsKey('statusCode')) {
      return false;
    } else {
      return true;
    }
  }

  static Future<CarData> getUnpaid(String carNum, IO.Socket socket) async {
    final completer = Completer<Map<String, dynamic>>();

    socket.emitWithAck('getUnpaid', {'carNum': carNum}, ack: (data) {
      completer.complete(data);
    });

    Map<String, dynamic> result = await completer.future;

    if (result.containsKey('paymentId')) {
      return CarData.fromJson(result);
    } else {
      throw Exception(result['statusCode']);
    }
  }
}
