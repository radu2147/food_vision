import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_vision/error/food_error.dart';
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
    } catch(e){
      error = FoodError(e.toString());
    }
    loading = false;
    notifyListeners();
  }
}