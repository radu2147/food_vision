import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/error/food_error.dart';
import 'package:food_vision/models/meal.dart';
import 'package:food_vision/models/prediction.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

const url = 'http://192.168.43.6:8000';

class FoodApiCall{
  Future addMeal(Meal meal) async {
    var uri = Uri.parse("$url/meal");
    var token = await FlutterSecureStorage().read(key: "token");
    try {
      var resp = await http.post(uri, body: jsonEncode(meal.toJson()),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer ${token ?? ""}"
          }).timeout(const Duration(seconds: 20));
      if (resp.statusCode == 401) {
        var error = jsonDecode(resp.body);
        var er = FoodError(error["detail"], code: 401);
        throw er;
      }
    }on FoodError{
      rethrow;
    } catch(_){
      throw FoodError("Something went wrong");
    }
  }

  Future<List<Meal>> getMealsOfToday(DateTime date) async{
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    var uri = Uri.parse("$url/meal?datetime=$date");
    try {
      var resp = await http.get(
          uri, headers: {"Authorization": "Bearer ${token ?? ""}"}).timeout(
          const Duration(seconds: 20));
      if (resp.statusCode == 401) {
        var error = jsonDecode(resp.body);
        var er = FoodError(error["detail"], code: 401);
        throw er;
      }
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
    on FoodError{
      rethrow;
    }
    catch(_){
      throw FoodError("Something went wrong");
    }
  }

  Future<Prediction> predictImage(File imageFile) async {
    print("attempting to connect to server……");
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("$url/uploadfile/");
    print("connection established.");
    try {
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile(
          "file", stream, length, filename: basename(imageFile.path));
      request.files.add(multipartFile);
      var response = await request.send().timeout(const Duration(seconds: 40));
      var resp = await http.Response.fromStream(response);
      if (resp.statusCode == 401) {
        var error = jsonDecode(resp.body);
        var er = FoodError(error["detail"], code: 401);
        throw er;
      }

      return Prediction.fromJson(jsonDecode(resp.body));
    } on FoodError catch(_){
      rethrow;
    } catch(e){
      throw FoodError("Something went wrong");
    }
  }
}