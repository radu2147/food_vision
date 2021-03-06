import 'dart:convert';

import 'package:food_vision/models/user.dart';
import 'package:http/http.dart' as http;

const url = 'http://192.168.43.6:8000';

class AuthApiCall{
  Future<Token> login(String username, String password) async {
    try {
      var uri = Uri.parse("$url/login");
      var resp = await http.post(uri, body: jsonEncode({"username": username, "password": password}), headers: {"Content-type": "application/json"}).timeout(const Duration(seconds: 10));
      var body = jsonDecode(resp.body);
      if(resp.statusCode != 200){
        if(resp.statusCode == 401){
          throw body["detail"];
        }
        throw "Something went wrong";
      }

      var token = Token.fromJson(body);
      return token;
    }
    catch(_){
      throw "Something went wrong";
    }

  }

  Future<Token> register(String username, String password) async{
    try {
      var uri = Uri.parse("$url/register");
      var resp = await http.post(uri, body: jsonEncode({"username": username, "password": password}), headers: {"Content-type": "application/json"}).timeout(const Duration(seconds: 10));
      var body = jsonDecode(resp.body);
      if(resp.statusCode != 200){
        if(resp.statusCode == 401){
          throw body["detail"];
        }
        throw "Something went wrong";
      }

      var token = Token.fromJson(body);
      return token;
    }
    catch(_){
      throw "Something went wrong";
    }
  }

}