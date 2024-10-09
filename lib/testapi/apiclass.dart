import 'dart:convert';
import 'package:flowkit/testapi/testapimodel.dart';
import 'package:http/http.dart' as http;

Future<AuthorizationResponse?> authorizeWithMobileNo(
    String deviceCode, String mobileNo, String fcmCode) async {
  final url = Uri.parse(
      'https://app.innerwheel.co.in/api/Authenticate/AuthorizationwithMobileNo');

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    "deviceCode": deviceCode,
    "mobileNo": mobileNo,
    "fcmCode": fcmCode,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Assuming the response is a JSON string
      String jsonResponse = response.body;
      return AuthorizationResponse.fromJson(jsonResponse);
    } else {
      print('Failed to authorize. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
