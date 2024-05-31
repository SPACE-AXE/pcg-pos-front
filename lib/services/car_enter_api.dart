// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://api.parkchargego.link/api/v1/parking-transaction'; // 일단 입력해놓음

  static Future<bool> sendCarNum(int parkId, String carNum) async {
    String url = '$_baseUrl/carnum';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'parkId': 1, 'carNum': carNum}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('${response.statusCode} Error, carNum: $carNum');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
