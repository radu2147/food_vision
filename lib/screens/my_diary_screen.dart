import 'package:flutter/material.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/widgets/app_bar.dart';
import 'package:food_vision/widgets/title_view.dart';
import 'package:provider/provider.dart';

import '../widgets/meals_list_view.dart';
import '../widgets/mediterranean_diet_view.dart';

class MyDiaryScreen extends StatefulWidget {

  List<Meal> data;

  MyDiaryScreen({Key? key, this.animationController, required this.data}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();

}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin{
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  get total{
    return widget.data.isEmpty ? 0.0 : widget.data.map((e) => e.nutritionalValues.kcal * e.quantity).reduce((value, element) => value + element);
  }

  get protein{
    return widget.data.isEmpty ? 0.0 : widget.data.map((e) => e.nutritionalValues.protein * e.quantity).reduce((value, element) => value + element);
  }

  get carbs{
    return widget.data.isEmpty ? 0.0 : widget.data.map((e) => e.nutritionalValues.carbs * e.quantity).reduce((value, element) => value + element);
  }

  get fat{
    return widget.data.isEmpty ? 0.0 : widget.data.map((e) => e.nutritionalValues.fat * e.quantity).reduce((value, element) => value + element);
  }

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        titleTxt: 'Diet overview',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      MediterranesnDietView(
        total: total,
        protein: protein,
        fat: fat,
        carbs: carbs,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      MealsListView(
        mealsData: widget.data,
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }

  Future<void> showSnackBar(String elem) async{
    final snackBar = SnackBar(
      content: Text("Error: " + elem),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<FoodViewModel>(context).error != null) {
      showSnackBar(Provider.of<FoodViewModel>(context, listen: false).error!.message);
      Provider.of<FoodViewModel>(context, listen: false).error = null;
    }
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
    );
  }

  Widget getAppBarUI() {
    return MyAppBar(date: DateTime.now(), animationController: widget.animationController, scrollController: scrollController,);
  }
}