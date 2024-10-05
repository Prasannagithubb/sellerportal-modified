import 'dart:developer';

import 'package:flowkit/model/reponce-model.dart';
import 'package:http/http.dart' as http;

class ServiceGet {
  static Future<Responce> callApi(String url, String token) async {
    try {
      final responce = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        "Authorization": "bearer $token"
      });
      if (!url.contains('GetallitembyUser')) {
        log("Body message: ${responce.body}");
        log("Body message: ${responce.statusCode}");
      }

      return Responce.getRes(responce.statusCode, responce.body);
    } catch (e) {
      log("Body message: $e");
      return Responce.getRes(500, '$e');
    }
  }
}
