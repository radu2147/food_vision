import 'package:food_vision/models/meal.dart';

class MealsListData {
  MealsListData({
    required this.titleTxt,
    required this.meals,
    this.kcal = 0,
  });

  get imagePath{
    switch(titleTxt){
      case MealType.Breakfast:
        return 'assets/fitness_app/breakfast.png';
      case MealType.Lunch:
        return 'assets/fitness_app/lunch.png';
      case MealType.Snack:
        return 'assets/fitness_app/snack.png';
      case MealType.Dinner:
        return 'assets/fitness_app/dinner.png';
    }
  }

  get startColor{
    switch(titleTxt){
      case MealType.Breakfast:
        return '#FA7D82';
      case MealType.Lunch:
        return '#738AE6';
      case MealType.Snack:
        return '#FE95B6';
      case MealType.Dinner:
        return '#6F72CA';
    }
  }

  get endColor{
    switch(titleTxt){
      case MealType.Breakfast:
        return '#FFB295';
      case MealType.Lunch:
        return '#5C5EDD';
      case MealType.Snack:
        return '#FF5287';
      case MealType.Dinner:
        return '#1E1466';
    }
  }

  MealType titleTxt;
  List<String> meals;
  double kcal;

}