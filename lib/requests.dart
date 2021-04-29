import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

class Response {
  final String message;
  final String result;

  Response({@required this.message, @required this.result});
  factory Response.fromJson(Map<dynamic, dynamic> json) {
    return Response(message: json['message'], result: json['result']);
  }

  String get response_message {
    return message;
  }

  String get response_result {
    return result;
  }
}

Future<Response> decipher(int cipherShift, String cipheredText) async {
  final response = await http.post(
    Uri.https('localhost:5000', '/decipher'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<dynamic, dynamic>{
      'cipherShift': cipherShift,
      'cipheredText': cipheredText
    }),
  );

  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get response');
  }
}

Future<Response> cipher(int cipherShift, String text) async {
  final response = await http.post(
    Uri.https('localhost:5000', '/cipher'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <dynamic, dynamic>{'cipherShift': cipherShift, 'cipheredText': text}),
  );

  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get response');
  }
}
