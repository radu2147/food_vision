import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/user.dart';

import 'auth_api_call.dart';

class AuthViewModel with ChangeNotifier{
  AuthApiCall api;

  Token? data;
  bool loading = false;
  FoodError? error;

  AuthViewModel(this.api);

  Future<Token> login(User user) async{
    return await api.login(user.username, user.password);
  }

  Future<Token> register(User user) async{
    return await api.register(user.username, user.password);
  }
}