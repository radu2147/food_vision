import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/screens/auth_screen.dart';
import 'package:food_vision/screens/fitness_app_home_screen.dart';
import 'package:food_vision/screens/loading_screen.dart';
import 'package:food_vision/service/auth_api_call.dart';
import 'package:food_vision/service/auth_view_model.dart';
import 'package:food_vision/service/camera_provider.dart';
import 'package:food_vision/service/food_api_call.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/service/add_view_model.dart';
import 'package:food_vision/service/predict_view_model.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Ensure plugin services are initialized
  final cameras = await availableCameras();
  var token = await const FlutterSecureStorage().read(key: "token");
  var username = await const FlutterSecureStorage().read(key: "username");
  FoodViewModel foodVM = FoodViewModel(FoodApiCall());
  AddViewModel addVM = AddViewModel(FoodApiCall());
  PredictViewModel predictVM = PredictViewModel(FoodApiCall());
  AuthViewModel authVM = AuthViewModel(AuthApiCall());
  CameraProvider cameraProvider = CameraProvider(cameras);
  if(token != null && username != null){
    authVM.data = Token(accessToken: token, tokenType: "bearer", username: username);
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => foodVM),
        ChangeNotifierProvider(create: (context) => addVM),
        ChangeNotifierProvider(create: (context) => predictVM),
        ChangeNotifierProvider(create: (context) =>  authVM),
        ChangeNotifierProvider(create: (context) =>  cameraProvider),
      ],child: MyApp(cameras: cameras, token: token))
  );
}

class MyApp extends StatelessWidget {

  final List<CameraDescription> cameras;
  final String? token;

  MyApp({Key? key, required this.cameras, this.token}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(token == null){
      return AuthScreen();
    }

    return MaterialApp(home: Scaffold(
          backgroundColor: Colors.transparent,
          body: _getWidget(context)
        )
      );
  }

  Widget _getWidget(BuildContext context){
    if(Provider.of<AuthViewModel>(context).error != null || Provider.of<FoodViewModel>(context).is401()){
      return AuthScreen();
    }
    return const FitnessAppHomeScreen();
  }

}
