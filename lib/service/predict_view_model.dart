import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';

import 'food_api_call.dart';

class PredictViewModel with ChangeNotifier{
  FoodApiCall api;
  bool loading = false;
  FoodError? error;

  Prediction? prediction;

  PredictViewModel(this.api);

  Future predictImage(File imageFile) async{
    loading = true;
    notifyListeners();
    try {
      prediction = await api.predictImage(imageFile);
      error = null;
    } on FoodError catch(e){
      error = e;
    }
    loading = false;
    notifyListeners();
  }

  Future<FoodError?> add(Meal meal) async{
    loading = true;
    notifyListeners();
    try {
      await api.addMeal(meal);
      error = null;
    } on FoodError catch(e){
      error = e;
    }
    loading = false;
    notifyListeners();
    return error;
  }
}