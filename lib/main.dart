import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/screens/auth_screen.dart';
import 'package:food_vision/screens/camera_screen.dart';
import 'package:food_vision/screens/fitness_app_home_screen.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';
import 'package:food_vision/screens/loading_screen.dart';
import 'package:food_vision/screens/my_diary_screen.dart';
import 'package:food_vision/service/api_call.dart';
import 'package:food_vision/service/auth_api_call.dart';
import 'package:food_vision/service/auth_service.dart';
import 'package:food_vision/service/auth_view_model.dart';
import 'package:food_vision/service/camera_provider.dart';
import 'package:food_vision/service/food_api_call.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/service/view_model.dart';
import 'package:provider/provider.dart';

import 'models/meal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Ensure plugin services are initialized
  final cameras = await availableCameras();
  var token = await const FlutterSecureStorage().read(key: "token");
  runApp(MyApp(cameras: cameras, token: token));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  final String? token;

  const MyApp({Key? key, required this.cameras, this.token}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var foodVM = FoodViewModel(FoodApiCall());
    var authVM = AuthViewModel(AuthApiCall());
    var cameraProvider = AuthViewModel(AuthApiCall());

    if(token == null){
      return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: foodVM),
            ChangeNotifierProvider.value(value: authVM),
            ChangeNotifierProvider.value(value: cameraProvider),
          ],
          child:AuthScreen());
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: foodVM),
          ChangeNotifierProvider.value(value: authVM),
          ChangeNotifierProvider.value(value: cameraProvider),
        ],
        child:MaterialApp(home: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<List<Meal>>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
              if(snapshot.hasError){
                return AuthScreen();
              } else if (!snapshot.hasData) {
                return Stack(
                  children: const <Widget>[
                    LoadingScreen()
                  ],
                );
              } else {
                var data = snapshot.data!;
                return FitnessAppHomeScreen(data: data, asnyc: false,);
              }
            },
          ),
        )
      )
    );
  }

}
