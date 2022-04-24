import 'package:food_vision/models/nutritional_values.dart';

class Prediction{

  String foodClass;
  NutritionalValues nutritionalValues;

  Prediction({required this.foodClass, required this.nutritionalValues});

  static Prediction fromJson(Map<String, Object?> map) => Prediction(
      foodClass: map["foodClass"] as String,
      nutritionalValues: NutritionalValues.fromJson(map["nutritional_values"] as Map<String, dynamic>),
  );
}