class Prediction{

  String foodClass;

  Prediction({required this.foodClass});

  static Prediction fromJson(Map<String, Object?> map) => Prediction(
      foodClass: map["foodClass"] as String,
  );
}