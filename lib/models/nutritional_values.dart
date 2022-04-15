import 'package:flutter/cupertino.dart';

class NutritionalValues{

  double kcal;
  double protein;
  double fat;
  double carbs;

  NutritionalValues({required this.kcal, required this.protein, required this.fat, required this.carbs});

  static fromJson(Map<String, dynamic> map) => NutritionalValues(
      kcal: map["kcal"] as double,
      protein: map["protein"] as double,
      fat: map["fats"] as double,
      carbs: map["carbs"] as double
  );

  Map<String, dynamic> toJson() => {
    "kcal": kcal,
    "protein": protein,
    "fats": fat,
    "carbs": carbs
  };
}