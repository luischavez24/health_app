import 'dart:convert';
import 'package:helth_exercises_app/models/benefit.dart';
import 'package:helth_exercises_app/models/exercise.dart';
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
}