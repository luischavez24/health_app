import 'package:flutter/material.dart';
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
          border: Border.all(
              style: BorderStyle.solid,
              width: 1.0
          ),
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
                    Text(
                      this.exercise.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      this.exercise.level,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      this.exercise.profit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    buildButton(
                      text: "VER MÁS",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ExercisesDetailPage(
                              key: Key(this.exercise.id),
                              exercise: this.exercise,
                            )
                        ));
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

    return Column(children: <Widget>[card,  SizedBox(height: 20.0,) ]);
  }
  
  Widget buildButton({ String text, Function onPressed }) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
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
          )
        )
    );
  }
}