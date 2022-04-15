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

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      titleTxt: MealType.Breakfast,
      kcal: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
    ),
    MealsListData(
      titleTxt: MealType.Lunch,
      kcal: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    ),
    MealsListData(
      titleTxt: MealType.Snack,
      kcal: 0,
      meals: <String>['Recommend:', '800 kcal'],
    ),
    MealsListData(
      titleTxt: MealType.Dinner,
      kcal: 0,
      meals: <String>['Recommend:', '703 kcal'],
    ),
  ];
}