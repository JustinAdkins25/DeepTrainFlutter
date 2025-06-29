import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const _region = 'us-east-1';
  static const _clientId = '6fa6tmfsbpb0r8rkjlm1tfgtj0';

  static final _baseUrl = 'https://cognito-idp.${_region}.amazonaws.com';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Content-Type': 'application/x-amz-json-1.1',
      },
    ),
  );

  /// Sign up a new user
  Future<bool> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final payload = {
      "ClientId": _clientId,
      "Username": email,
      "Password": password,
      "UserAttributes": [
        {"Name": "email", "Value": email},
        {"Name": "given_name", "Value": firstName},
        {"Name": "family_name", "Value": lastName}
      ]
    };

    try {
      debugPrint('SignUp Payload: ${jsonEncode(payload)}');

      final response = await _dio.post(
        '',
        options: Options(
          headers: {
            'X-Amz-Target': 'AWSCognitoIdentityProviderService.SignUp',
          },
        ),
        data: jsonEncode(payload),
      );

      debugPrint('SignUp Response: ${response.data}');

      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint('SignUp Error: ${e.response?.data}');
      throw Exception('${e.response?.data?["message"] ?? "Registration failed"}');
    }
  }

  /// Confirm user
  Future<bool> confirmUser(String email, String code) async {
    final payload = {
      "ClientId": _clientId,
      "Username": email,
      "ConfirmationCode": code,
    };

    try {
      debugPrint('Confirm Payload: ${jsonEncode(payload)}');

      final response = await _dio.post(
        '',
        options: Options(
          headers: {
            'X-Amz-Target': 'AWSCognitoIdentityProviderService.ConfirmSignUp',
          },
        ),
        data: jsonEncode(payload),
      );

      debugPrint('Confirm Response: ${response.data}');

      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint('Confirm Error: ${e.response?.data}');
      throw Exception('${e.response?.data?["message"] ?? "Confirmation failed"}');
    }
  }

  /// Sign in user
Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('https://cognito-idp.us-east-1.amazonaws.com/');

    final headers = {
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth',
    };

    final body = jsonEncode({
      'AuthFlow': 'USER_PASSWORD_AUTH',
      'ClientId': _clientId,
      'AuthParameters': {
        'USERNAME': email,
        'PASSWORD': password,
      }
    });

    final response = await http.post(url, headers: headers, body: body);
    print('Status code: \${response.statusCode}');
    print('Body: \${response.body}');

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return data['AuthenticationResult']['IdToken'] as String;
} else {
  try {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Login failed');
  } catch (_) {
    throw Exception('Login failed: ${response.body}');
  }
}

  }
}
