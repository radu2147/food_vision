import 'package:flutter/material.dart';
import 'package:food_vision/models/tablcon_data.dart';
import 'package:food_vision/screens/my_diary_screen.dart';
import 'package:food_vision/screens/training_screen.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/widgets/bottom_bar_view.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';
import 'camera_screen.dart';
import 'loading_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {


  const FitnessAppHomeScreen();

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();

}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  late Widget tabBody;
  late MyDiaryScreen diaryScreen;
  late TrainingScreen profileScreen;

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
    diaryScreen = MyDiaryScreen(data: Provider.of<FoodViewModel>(context, listen: false).data ?? [], animationController: animationController,);
    profileScreen = TrainingScreen(
      animationController: animationController,
    );
    tabBody = diaryScreen;
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<FoodViewModel>(context).is401()){
      return AuthScreen();
    }
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _getWidget(context)
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
    var data = Provider.of<FoodViewModel>(context).data!;
    diaryScreen.data = data;
    return Stack(
      children: <Widget>[
        tabBody, //MyDiaryScreen(data: data, animationController: animationController),
        bottomBar(),
      ],
    );
  }


  Widget bottomBar() {
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
                  tabBody = diaryScreen;
                });
              }
              else if(index == 1){
                setState(() {
                  tabBody = profileScreen;
                });
              }
            });
          },
        ),
      ],
    );
  }
}