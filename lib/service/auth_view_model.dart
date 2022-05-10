import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/error/auth_error.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/user.dart';

import 'auth_api_call.dart';

class AuthViewModel with ChangeNotifier{
  AuthApiCall api;

  Token? data;
  bool loading = false;
  AuthError? error;

  AuthViewModel(this.api);

  Future login(User user) async{
    loading = true;
    notifyListeners();
    try {
      data = await api.login(user.username, user.password);
      await _writeToStorage();
      error = null;
    } catch(e){
      error = AuthError(e.toString());
    }
    loading = false;
    notifyListeners();
  }

  Future _writeToStorage() async {
    var storage = const FlutterSecureStorage();
    await storage.write(key: "token", value: data!.accessToken);
    await storage.write(key: "username", value: data!.username);
  }

  Future register(User user) async{
    loading = true;
    notifyListeners();
    try {
      data = await api.register(user.username, user.password);
      await _writeToStorage();
      error = null;
    } catch(e){
      error = AuthError(e.toString());
    }
    loading = false;
    notifyListeners();
  }
}