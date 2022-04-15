import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/tablcon_data.dart';
import 'package:food_vision/screens/my_diary_screen.dart';
import 'package:food_vision/screens/training_screen.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/service/view_model.dart';
import 'package:food_vision/widgets/bottom_bar_view.dart';
import 'package:provider/provider.dart';

import 'camera_screen.dart';
import 'fitness_app_theme.dart';
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

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

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
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.asnyc) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<List<Meal>>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
              if (!snapshot.hasData) {
                return Stack(
                    children: const <Widget>[
                      LoadingScreen()
                    ],
                );
              } else {
                var data = snapshot.data!;
                return Stack(
                  children: <Widget>[
                    MyDiaryScreen(data: data, animationController: animationController),
                    bottomBar(data),
                  ],
                );
              }
            },
          ),
        );
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
              children: <Widget>[
                MyDiaryScreen(data: widget.data!, animationController: animationController),
                bottomBar(widget.data!),
              ],
            )


      );
  }

  Future<List<Meal>> getData() async {
      return await Provider.of<FoodViewModel>(context, listen: false).getAll();
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
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(data: lst, animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}