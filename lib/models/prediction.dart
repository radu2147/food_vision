class Prediction{

  String foodClass;
  double prediction;

  Prediction({required this.foodClass, required this.prediction});

  double get predict{
    return (prediction * 100).ceil() / 100;
  }

  String get food{
    return foodClass.split("_").map((e) => "${e[0].toString().toUpperCase()}${e.toString().substring(1).toLowerCase()}").join(" ");
  }

  static Prediction fromJson(Map<String, Object?> map) => Prediction(
      foodClass: map["foodClass"] as String,
      prediction: map["prediction"] as double
  );
}