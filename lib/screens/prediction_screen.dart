import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';
import 'package:food_vision/screens/error_screen.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';
import 'package:food_vision/screens/info_screen.dart';
import 'package:food_vision/screens/loading_screen.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class PredictionScreen extends StatefulWidget{

  File imageFile;
  MealType? mealType;

  PredictionScreen({Key? key, required this.imageFile, this.mealType}) : super(key: key);

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> with TickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState(){
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
        body: Stack(
        children: [
          _build(context),
          MyAppBar(date: DateTime.now(), scrollController: ScrollController(), animationController: animationController,),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      )
    );
  }

  Widget _getCameraPic(Widget message){
    return Stack(
      children: <Widget>[
        MyAppBar(date: DateTime.now(), scrollController: ScrollController(), animationController: animationController,),
        Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: Image(
                image: FileImage(widget.imageFile),
              ),
            ),
          ],
        ),
        Positioned(
          top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.nearlyWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0)
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
                ],
              ),
              child: message
        )
    ),
        // Padding(
        //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        //   child: SizedBox(
        //     width: AppBar().preferredSize.height,
        //     height: AppBar().preferredSize.height,
        //   ),
        // )
    ]
    );
  }

  Widget _build(BuildContext context) {
    if (Provider
        .of<FoodViewModel>(context)
        .loading) {
      return const LoadingScreen();
    }
    if (Provider
        .of<FoodViewModel>(context)
        .error != null) {
      return _getCameraPic(
          ErrorScreen(error: "Error calling the api")
      );
    }
    if (Provider
        .of<FoodViewModel>(context)
        .error == null) {
      Prediction data = Provider
          .of<FoodViewModel>(context)
          .prediction!;
      if (data.prediction < .6) {
        return _getCameraPic(
            ErrorScreen(error: "No food detected")
        );
      }
      return _getCameraPic(InfoScreen(imageFile: widget.imageFile,
          prediction: data,
          mealType: widget.mealType));
    }
    return _getCameraPic(
        ErrorScreen(error: Provider.of<FoodViewModel>(context).error!.message)
    );
  }


}