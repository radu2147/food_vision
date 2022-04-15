import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';

import 'food_api_call.dart';

class FoodViewModel with ChangeNotifier{

  FoodApiCall api;

  List<Meal>? data;
  bool loading = false;
  FoodError? error;

  FoodViewModel(this.api);

  Future getAll() async{
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday();
    } catch(e){
      error = FoodError(e.toString());
    }
    loading = false;
    notifyListeners();
  }
}