import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';

import 'food_api_call.dart';

class FoodViewModel with ChangeNotifier{

  FoodApiCall api;

  List<Meal>? data;
  bool loading = false;
  FoodError? error;
  DateTime date = DateTime.now();

  FoodViewModel(this.api) {
    getAll();
  }

  Future getAll() async{
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday(date);
      error = null;
    } catch(e){
      error = FoodError(e.toString());
    }
    loading = false;
    notifyListeners();
  }


}