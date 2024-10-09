import 'dart:convert';

class AuthorizationResponse {
  final String
      someField; // Adjust this field based on the actual response structure

  AuthorizationResponse({required this.someField});

  factory AuthorizationResponse.fromJson(String json) {
    return AuthorizationResponse(
      someField: json.toString(), // Map actual response fields
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'someField': someField, // Adjust according to fields
    };
  }
}
