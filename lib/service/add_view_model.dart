
import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';

import 'food_api_call.dart';

class AddViewModel with ChangeNotifier{
  FoodApiCall api;
  bool loading = false;
  FoodError? error;

  AddViewModel(this.api);

  Future add(Meal meal) async{
    loading = true;
    notifyListeners();
    try {
      await api.addMeal(meal);
      error = null;
    } catch(e){
      error = FoodError(e.toString());
    }
    loading = false;
    notifyListeners();
  }
}