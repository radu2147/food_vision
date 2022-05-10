import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/nutritional_values.dart';
import 'package:food_vision/models/prediction.dart';
import 'package:food_vision/models/user.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:food_vision/service/add_view_model.dart';
import 'package:food_vision/widgets/counter_view.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'fitness_app_theme.dart';

class InfoScreen extends StatefulWidget {

  File imageFile;
  Prediction prediction;
  MealType? mealType;

  InfoScreen({Key? key, required this.imageFile, required this.prediction, this.mealType}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  late MealType dropdownValue;
  int quantity = 1;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    dropdownValue = widget.mealType ?? MealType.Breakfast;
    setData();
    super.initState();
  }

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if(!mounted) {
      return;
    }
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if(!mounted) {
      return;
    }
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if(!mounted) {
      return;
    }
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Row(children: [Text(
                              widget.prediction.foodClass,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                letterSpacing: 1.2,
                                color: FitnessAppTheme.darkerText,
                              ),
                            ),
                              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                              DropdownButton(

                                // Initial Value
                                value: dropdownValue,
                                style: FitnessAppTheme.body1,
                                alignment: Alignment.topCenter,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                selectedItemBuilder: (BuildContext context) {
                                  return MealType.values.map<Widget>((MealType item) {
                                    return Container(
                                        alignment: Alignment.centerLeft,
                                        width: 100,
                                        child: Text(item.toText(), textAlign: TextAlign.end)
                                    );
                                  }).toList();
                                },

                                // Array list of items
                                items: MealType.values.map((MealType items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toText(), textAlign: TextAlign.end,),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (MealType? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ]
                            ),
                          ),

                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  'Valorile nutritionale per 100 grame produs:',
                                  textAlign: TextAlign.justify,
                                  style: FitnessAppTheme.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI((widget.prediction.nutritionalValues.kcal * quantity).toString(), 'Kcal'),
                                  getTimeBoxUI('${widget.prediction.nutritionalValues.protein * quantity}g', 'Protein'),
                                  getTimeBoxUI('${widget.prediction.nutritionalValues.fat * quantity}g', 'Fat'),
                                ],
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity2,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Text(
                                'Select quantity:',
                                textAlign: TextAlign.justify,
                                style: FitnessAppTheme.caption,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                          ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child:
                                CounterView(
                                  minNumber: 1,
                                  initNumber: 1,
                                  onChange: (value) {
                                    setState(() {
                                      quantity = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          const Expanded(
                            child: Divider(thickness: 0),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        gradient: const LinearGradient(
                                            colors: [
                                              FitnessAppTheme.nearlyDarkBlue,
                                              FitnessAppTheme.dark_grey
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme.nearlyDarkBlue
                                                  .withOpacity(0.4),
                                              offset: const Offset(8.0, 6.0),
                                              blurRadius: 16.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async{
                                              await Provider.of<AddViewModel>(context, listen: false).add(Meal(
                                                  name: widget.prediction.foodClass,
                                                  mealType: dropdownValue,
                                                  date: Provider.of<FoodViewModel>(context, listen: false).date,
                                                  user: User(username: "", password: ""),
                                                  id: BigInt.from(-1),
                                                  quantity: quantity,
                                                  nutritionalValues: widget.prediction.nutritionalValues
                                              ));
                                              Navigator.popUntil(context, (route) => route.isFirst);
                                              await Provider.of<FoodViewModel>(context, listen: false).getAllToday();
                                            },
                                            splashColor: Colors.white.withOpacity(0.1),
                                            highlightColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            child: const Text(
                                              'Log meal',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: AppTheme
                                                    .nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.nearlyDarkBlue,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 21,
                  letterSpacing: 0.27,
                  color: FitnessAppTheme.nearlyBlue,
                ),
              ),
              const Divider(color: FitnessAppTheme.nearlyBlack, thickness: 5,indent: 20, // empty space to the leading edge of divider.
                endIndent: 20, ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: FitnessAppTheme.nearlyBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}