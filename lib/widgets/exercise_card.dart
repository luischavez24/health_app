import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:helth_exercises_app/models/exercise.dart';
import 'package:helth_exercises_app/views/exercises/exercise_detail.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exerciseModel;

  ExerciseCard(this.exerciseModel);

  @override
  State createState() => ExerciseCardState(this.exerciseModel);
}

class ExerciseCardState extends State<ExerciseCard> {
  Exercise exercise;
  ExerciseCardState(this.exercise);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    final card =  Container(
        key: Key(this.exercise.id),
        decoration: BoxDecoration(
          color:  Color.fromRGBO(209, 224, 224, 0.2),
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          child: Column(
            children: <Widget>[
              Image.network(this.exercise.imageUrl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(this.exercise.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.0),
                    Text(this.exercise.level,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(this.exercise.profit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    buildButton(
                      text: "VER MÁS",
                      onPressed: () {
                        var materialRoute = MaterialPageRoute(
                          builder: (context) => ExerciseDetailPage(
                            key: Key(this.exercise.id),
                            exercise: this.exercise,
                          )
                        );
                        Navigator.of(context).push(materialRoute);
                      }
                    )
                  ],
                ),
              )
            ],
          ),
          borderRadius: borderRadius,
        )
    );

    return Column(
      children: <Widget>[
        card,  SizedBox(height: 20.0,) 
      ]
    );
  }
  
  Widget buildButton({ String text, Function onPressed }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width / 2,
      child: RaisedButton(
        onPressed: onPressed,
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w700
          )
        ),
        shape: SuperellipseShape(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      )
    );
  }
}