import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/api_response.dart';


class ApiService {
  static const String API = 'http://127.0.0.1:8001';
  //TODO: Setup authentication
  static const headers = {
    'Authorization': 'Bearer your_token_here',
    'Content-Type': 'application/json',
    'apiKey': 'testapikey'
  };

  Future<ApiResponse<String>> askUserQuestion(String question) async {
    try {
      final response = await http.post(
        Uri.parse(API+"/users/ques"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'question': question,
          'history': []
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String responseBody =  data['text'];
        return ApiResponse<String>(data: responseBody);
      } else {
        return ApiResponse<String>(
          data: '',
          error: true,
          errorMessage: 'Failed to fetch data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse<String>(
        data: '',
        error: true,
        errorMessage: 'An error occurred: $e',
      );
    }
  }
}
