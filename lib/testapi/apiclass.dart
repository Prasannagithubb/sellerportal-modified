import 'dart:convert';
import 'package:flowkit/testapi/testapimodel.dart';
import 'package:http/http.dart' as http;

Future<AuthorizationResponse?> authorizeWithMobileNo(
    String deviceCode, String mobileNo, String fcmCode) async {
  final response = await http.post(
      Uri.parse(
          'https://app.innerwheel.co.in/api/Authenticate/AuthorizationwithMobileNo'),
      headers: {
        "Content-Type": "text/plain",
      },
      body: jsonEncode({
        "deviceCode": deviceCode,
        "mobileNo": mobileNo,
        "fcmCode": fcmCode,
      }));
  try {
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
