import 'package:flutter/material.dart';
import 'package:helth_exercises_app/api/health_api.dart';
import 'package:helth_exercises_app/widgets/common.dart';
import 'package:helth_exercises_app/widgets/exercise_card.dart';

class ExerciseView extends StatefulWidget {
  @override
  State createState() => ExerciseViewState();
}

class ExerciseViewState extends State<ExerciseView> {
  final HealthApi _healthApi = HealthApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _healthApi.fetchExercises(0, 20),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            final exercises = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) => ExerciseCard(exercises[index])
              ),
            );
          }
        } else if(snapshot.hasError) {
          return ErrorDisplay(errorDetail: snapshot.error.toString());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}