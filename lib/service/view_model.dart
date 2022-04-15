import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';
import 'package:food_vision/service/api_call.dart';

class ViewModel{

  ApiCall api;

  ViewModel(this.api);

  Future<Prediction> predictImage(File imageFile){
    return api.predictImage(imageFile);
  }

  Future<List<Meal>> getAll(){
    return api.getMealsOfToday();
  }

  void add(Meal meal) async{
    api.addMeal(meal);
  }
}