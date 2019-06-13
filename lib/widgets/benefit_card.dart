import 'package:flutter/material.dart';
import 'package:helth_exercises_app/models/benefit.dart';
import 'package:helth_exercises_app/views/benefits/benefit_detail.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class BenefitsCard extends StatefulWidget {
  final Benefit benefit;

  BenefitsCard(this.benefit);

  @override
  State createState() => BenefitsCardState(this.benefit);
}

class BenefitsCardState extends State<BenefitsCard> {
  Benefit benefit;
  BenefitsCardState(this.benefit);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    final card =  Container(
        key: Key(this.benefit.id),
        decoration: BoxDecoration(
          color:  Color.fromRGBO(209, 224, 224, 0.2),
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          child: Column(
            children: <Widget>[
              Image.network(this.benefit.imageUrl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      this.benefit.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Necesitas ${this.benefit.points} puntos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    buildButton(
                        text: "VER MÁS",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BenefitDetailPage(
                                key: Key(this.benefit.id),
                                benefit: this.benefit,
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