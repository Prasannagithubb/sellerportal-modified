import 'dart:convert';
import 'dart:developer';

import 'package:flowkit/model/reponce-model.dart';
import 'package:http/http.dart' as http;

class ServiceUpdate {
  static Future<Responce> callApi(
      String url, String token, Map<String, dynamic> body,{List<Map<String ,dynamic>>? listbody}) async {
    try {
      log(jsonEncode(body.isEmpty?listbody:body));
      final responce = await http.put(Uri.parse( url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'bearer $token',
          },
          body: jsonEncode(body.isEmpty?listbody:body));
      log("Body message: ${responce.body}");
      log("Body message: ${responce.statusCode}");
      return Responce.getRes(responce.statusCode, responce.body);
    } catch (e) {
      log("Body message: $e");
      return Responce.getRes(500, '$e');
    }
  }
}
