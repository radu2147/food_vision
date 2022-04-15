import 'package:food_vision/models/user.dart';
import 'package:food_vision/service/api_call.dart';

class AuthService{

  ApiCall apiCall;

  AuthService(this.apiCall);

  Future<Token> login(User user) async{
    return await apiCall.login(user.username, user.password);
  }

  Future<Token> register(User user) async{
    return await apiCall.register(user.username, user.password);
  }
}