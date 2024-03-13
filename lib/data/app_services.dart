import 'dart:convert';

import 'response_model.dart';
import 'package:http/http.dart' as http;

class AppService{
  Future<ApiResponseModel> fetchStackApi() async {
  final response = await http
      .get(Uri.parse('https://api.stackexchange.com/2.3/search?tagged=flutter&site=stackoverflow'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ApiResponseModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
}