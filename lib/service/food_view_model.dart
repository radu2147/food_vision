
import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';

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

  bool is401() {
    return error?.code == 401;
  }

  Future getAll() async{
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday(date);
      error = null;
    } on FoodError catch(e){
      error = e;
      error?.code = 401;
    }
    loading = false;
    notifyListeners();
  }

  Future getAllToday() async{
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday(date);
      error = null;
    } on FoodError catch(e){
      error = e;
    }
    loading = false;
    notifyListeners();
  }

  Future getAllYesterday() async{
    date = date.subtract(const Duration(days:1));
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday(date);
      error = null;
    } on FoodError catch(e){
      error = e;
      date = date.add(const Duration(days:1));
    }
    loading = false;
    notifyListeners();
  }

  Future getAllTomorrow() async{
    date = date.add(const Duration(days:1));
    loading = true;
    notifyListeners();
    try {
      data = await api.getMealsOfToday(date);
      error = null;
    } on FoodError catch(e){
      error = e;
      date = date.subtract(const Duration(days:1));
    }
    loading = false;
    notifyListeners();
  }

}