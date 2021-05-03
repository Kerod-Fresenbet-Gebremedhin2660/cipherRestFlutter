import 'package:http/http.dart' as http;
import 'dart:convert';

class Response {
  final String message;
  final String result;
  static http.Client httpClient = new http.Client();

  Response({required this.message, required this.result});

  factory Response.fromJson(Map<dynamic, dynamic> json) {
    return Response(message: json['message'], result: json['result']);
  }

  String get response_message {
    return message;
  }

  String get response_result {
    return result;
  }

  static Future<Response> decipher(int cipherShift, String cipheredText) async {
    final response = await httpClient.post(
      Uri.http('192.168.12.1:5000', '/api/decipher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'cipher_shift': cipherShift,
        'ciphered_text': cipheredText
      }),
    );

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get response');
    }
  }

  static Future<Response> cipher(int cipherShift, String text) async {
    final response = await httpClient.post(
      Uri.http('192.168.12.1:5000', '/api/cipher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'cipher_shift': cipherShift,
        'to_be_ciphered_text': text
      }),
    );

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get response');
    }
  }
}
