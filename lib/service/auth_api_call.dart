import 'dart:convert';

import 'package:food_vision/models/user.dart';
import 'package:http/http.dart' as http;

const url = 'http://192.168.43.6:8000';

class AuthApiCall{
  Future<Token> login(String username, String password) async {
    var uri = Uri.parse("$url/login");
    var resp = await http.post(uri, body: jsonEncode({"username": username, "password": password}), headers: {"Content-type": "application/json"}).timeout(const Duration(seconds: 10));
    var body = jsonDecode(resp.body);
    return Token.fromJson(body);
  }

  Future<Token> register(String username, String password) async{
    var uri = Uri.parse("$url/register");
    var resp = await http.post(uri, body: jsonEncode({"username": username, "password": password}), headers: {"Content-type": "application/json"}).timeout(const Duration(seconds: 10));
    var body = jsonDecode(resp.body);
    return Token.fromJson(body);
  }

}