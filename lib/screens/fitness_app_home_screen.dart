import 'package:flutter/material.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/tablcon_data.dart';
import 'package:food_vision/screens/auth_screen.dart';
import 'package:food_vision/screens/error_screen.dart';
import 'package:food_vision/screens/my_diary_screen.dart';
import 'package:food_vision/screens/training_screen.dart';
import 'package:food_vision/service/auth_view_model.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/widgets/bottom_bar_view.dart';
import 'package:provider/provider.dart';

import 'camera_screen.dart';
import 'loading_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {

  final List<Meal>? data;
  bool asnyc;

  FitnessAppHomeScreen({this.data,required this.asnyc});

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  late Widget tabBody;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    );
    tabBody = MyDiaryScreen(data: Provider.of<FoodViewModel>(context, listen: false).data!, animationController: animationController,);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<AuthViewModel>(context).error != null){
      return AuthScreen();
    }
    if(widget.asnyc) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: _getWidget(context)
        );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
              children: <Widget>[
                tabBody,
                bottomBar(widget.data!),
              ],
            )


      );
  }

  Widget _getWidget(BuildContext context){
    if (Provider.of<FoodViewModel>(context).loading) {
      return Stack(
        children: const <Widget>[
          LoadingScreen()
        ],
      );
    }
    if(Provider.of<FoodViewModel>(context).error != null){
      return ErrorScreen(error: Provider.of<FoodViewModel>(context).error!.message,);
    }
    var data = Provider.of<FoodViewModel>(context).data!;
    return Stack(
      children: <Widget>[
        tabBody, //MyDiaryScreen(data: data, animationController: animationController),
        bottomBar(data),
      ],
    );
  }

  Widget bottomBar(List<Meal> lst) {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));},
          changeIndex: (int index) {
            animationController?.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              if(index == 0) {

                setState(() {
                  tabBody = MyDiaryScreen(
                      data: lst, animationController: animationController);
                });
              }
              else if(index == 1){
                setState(() {
                  tabBody = TrainingScreen(
                    animationController: animationController,
                  );
                });
              }
            });
          },
        ),
      ],
    );
  }
}