import 'package:food_vision/models/user.dart';

import 'nutritional_values.dart';

enum MealType{
  Breakfast, Lunch, Snack, Dinner
}

extension MealTypeExtension on MealType{
  String toText(){
    switch(this){
      case MealType.Breakfast:
        return "Breakfast";
      case MealType.Dinner:
        return "Dinner";
      case MealType.Lunch:
        return "Lunch";
      case MealType.Snack:
        return "Snack";
    }
  }
}

MealType? _fromString(String text){
  switch(text){
    case "Breakfast":
      return MealType.Breakfast;
    case "Lunch":
      return MealType.Lunch;
    case "Dinner":
      return MealType.Dinner;
    case "Snack":
      return MealType.Snack;
  }
}

class Meal{
  User user;
  DateTime date;
  NutritionalValues nutritionalValues;
  MealType mealType;
  String name;
  BigInt id;
  int quantity;

  Meal({required this.user, required this.date, required this.nutritionalValues, required this.mealType, required this.name, required this.id, this.quantity = 1});


  static Meal fromJson(Map<String, dynamic> map) => Meal(
      id: BigInt.from(map["id"] as int),
      date: DateTime.parse(map["date"]),
      name: map["name"] as String,
      mealType: _fromString(map["meal_type"] as String) ?? MealType.Snack,
      nutritionalValues: NutritionalValues.fromJson(map["nutritional_values"] as Map<String, dynamic>),
      user: User.fromJson(map["user"] as Map<String, dynamic>),
      quantity: map["quantity"] as int
  );

  Map<String, dynamic> toJson() => {
    "id": -1,
    "date": date.toString(),
    "meal_type": mealType.toText(),
    "name": name,
    "nutritional_values": nutritionalValues.toJson(),
    "user": user.toJson(),
    "quantity": quantity.toString()
  };

}