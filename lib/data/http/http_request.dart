import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpRequest {
  Future<http.Response> getJson(String url) async {
    return await http.get(Uri.parse(url));
  }

  Future<http.Response> postJson(String url, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(body),
    );
  }

  Future<http.Response> postListJson(String url, List<dynamic> body) async {
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(body),
    );
  }

  Future<http.Response> putJson(String url, Map<String, dynamic> body) async {
    return await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(body),
    );
  }

  Future<http.Response> deleteJson(String url) async {
    return await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
