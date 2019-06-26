import 'dart:convert';
import 'package:helth_exercises_app/models/benefit.dart';
import 'package:helth_exercises_app/models/exercise.dart';
import 'package:helth_exercises_app/models/user_profile.dart';
import 'package:http/http.dart';

class HealthApi {
  String _baseURL = "https://apihealth.herokuapp.com/api";

  Future<List<Exercise>> fetchExercises(int skip, int limit) async{
    final response =  await get("${this._baseURL}/exercises?skip=$skip&limit=$limit");

    if(response.statusCode == 200) {

      final results = json.decode(response.body)["results"];
      if(results is List) {
        return results.map((exercise) => Exercise.fromJson(exercise)).toList();
      } else {
        throw Exception("Not array");
      }
    } else {
      throw Exception("Fetching fail");
    }
  }

  Future<List<Benefit>> fetchBenefits(int skip, int limit) async{
    final response =  await get("${this._baseURL}/benefits?skip=$skip&limit=$limit");

    if(response.statusCode == 200) {

      final results = json.decode(response.body)["results"];
      if(results is List) {
        return results.map((exercise) => Benefit.fromJson(exercise)).toList();
      } else {
        throw Exception("Not array");
      }
    } else {
      throw Exception("Fetching fail");
    }
  }

  Future<double> getCalories(String accessToken) async {

    if(accessToken == null) {
      throw Exception("El usuario no se auntenticó correctamente");
    }
    // Request headers
    var headers = {
      'Content-Type': 'application/json; encoding=utf-8',
      'Authorization': 'Bearer $accessToken'
    };
    // Calculating time
    var endTime = DateTime.now();
    var startTime = endTime.subtract(Duration(days: 5));
    var startTimeMillis = startTime.millisecondsSinceEpoch;
    var endTimeMillis = endTime.millisecondsSinceEpoch;
    // Request body
    var body = {
      "aggregateBy": [
        {
          "dataSourceId": "derived:com.google.calories.expended:com.google.android.gms:from_activities",
          "dataTypeName": "com.google.calories.expended"
        }
      ],
      "endTimeMillis": endTimeMillis,
      "startTimeMillis": startTimeMillis,
      "bucketByTime": {
        "durationMillis": (endTimeMillis - startTimeMillis)
      }
    };
    // Make request
    final response = await post('https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate',
        body: json.encode(body),
        headers: headers
    );

    if(response.statusCode == 200) {
      var buckets = json.decode(response.body)["bucket"];
      if(buckets is List) {
        var datasets = buckets.first["dataset"];
        if(datasets is List) {
          var calories = _getBucketValue(datasets)["fpVal"];
          return calories is double ? calories : 0.0;
        }
      }
    } else {
      throw Exception("Fetching fail");
    }
    return 0.0;
  }

  Map<String, dynamic> _getBucketValue(List datasets) {
    var points = datasets.first["point"];
    if(points is List) {
      var values = points.first["value"];
      if(values is List) {
        return values.first;
      }
    }
    return {};
  }

  Future<List<CaloriesHistory>> getCaloriesHistory(String accessToken) async {

    if(accessToken == null) {
      throw Exception("El usuario no se auntenticó correctamente");
    }
    // Request headers
    var headers = {
      'Content-Type': 'application/json; encoding=utf-8',
      'Authorization': 'Bearer $accessToken'
    };
    // Calculating time
    var endTime = DateTime.now();
    var startTime = endTime.subtract(Duration(days: 5));
    var startTimeMillis = startTime.millisecondsSinceEpoch;
    var endTimeMillis = endTime.millisecondsSinceEpoch;
    // Request body
    var body = {
      "aggregateBy": [
        {
          "dataSourceId": "derived:com.google.calories.expended:com.google.android.gms:from_activities",
          "dataTypeName": "com.google.calories.expended"
        }
      ],
      "endTimeMillis": endTimeMillis,
      "startTimeMillis": startTimeMillis,
      "bucketByTime": {
        "period": {
          "type": "day",
          "value": 1,
          "timeZoneId": "America/Lima"
        }
      }
    };
    // Make request
    final response = await post('https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate',
        body: json.encode(body),
        headers: headers
    );

    if(response.statusCode == 200) {
      var buckets = json.decode(response.body)["bucket"];
      if(buckets is List) {
        return buckets.asMap().map((index, bucket){
          if(bucket["dataset"] is List) {
            var bucketValue = _getBucketValue(bucket["dataset"])["fpVal"];
            return MapEntry(index, CaloriesHistory(
              calories: bucketValue is double ? bucketValue.round() : 0,
              day: "$index",
              dayNumber: index
            ));
          }
        })
        .values
        .toList();
      }
    } else {
      throw Exception("Fetching fail");
    }
    return [];
  }
}