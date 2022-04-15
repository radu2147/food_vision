import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

const url = 'http://192.168.43.6:8000';

class FoodApiCall{
  void addMeal(Meal meal) async {
    var uri = Uri.parse("$url/meal");
    var token = await FlutterSecureStorage().read(key: "token");
    var resp = await http.post(uri, body: jsonEncode(meal.toJson()), headers: {"Content-type": "application/json", "Authorization": "Bearer ${token ?? ""}"});
    var body = jsonDecode(resp.body);
  }

  Future<List<Meal>> getMealsOfToday() async{
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    var uri = Uri.parse("$url/meal?datetime=${DateTime.now()}");
    var resp = await http.get(uri, headers: {"Authorization": "Bearer ${token ?? ""}"});
    List<dynamic> values = jsonDecode(resp.body);
    List<Meal> fin = [];
    if (values.isNotEmpty) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          var elem = Meal.fromJson(map);
          fin.add(elem);
        }
      }
    }
    return fin;
  }

  Future<Prediction> predictImage(File imageFile) async {
    print("attempting to connect to server……");
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("$url/uploadfile/");
    print("connection established.");
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("file", stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response =    await request.send().timeout(const Duration(seconds: 120));
    var respBody = await http.Response.fromStream(response);

    return Prediction.fromJson(jsonDecode(respBody.body));
  }
}