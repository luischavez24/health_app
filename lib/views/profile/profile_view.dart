import 'package:flutter/material.dart';
import 'package:helth_exercises_app/models/user_profile.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProfileView extends StatefulWidget {
  @override
  State createState() => ProfileViewState();
}

class PointsPerMonth {
  String month;
  int monthNumber = 1;
  int points;
  PointsPerMonth({
    this.month,
    this.monthNumber,
    this.points
  });
}

class ProfileViewState extends State<ProfileView> {
  final userProfile = UserProfile(
    email: 'sconnor@skynet.com',
    firstName: 'Sarah',
    lastName: 'Connor',
    points: 7000,
    profileImageUrl: 'https://media.metrolatam.com/2018/08/01/lindahamiltonsarahconnor-03bceffbabf3e11cfb7bec709130d42f-600x400.jpg'
  );

  var series = [
    charts.Series<PointsPerMonth, int>(
      id: 'PointsPerMonth',
      colorFn: (_,__) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (PointsPerMonth pointsPerMonth, _) => pointsPerMonth.monthNumber,
      measureFn: (PointsPerMonth pointsPerMonth, _) => pointsPerMonth.points,
      displayName: "Puntos al mes",
      data: [
        PointsPerMonth(monthNumber: 0, month: 'Enero', points: 500),
        PointsPerMonth(monthNumber: 1, month: 'Febrero', points: 1000),
        PointsPerMonth(monthNumber: 2, month: 'Marzo', points: 800),
        PointsPerMonth(monthNumber: 3, month: 'Abril', points: 5000),
        PointsPerMonth(monthNumber: 4, month: 'Mayo', points: 6000),
        PointsPerMonth(monthNumber: 5, month: 'Junio', points: 7000),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var axis = charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 10,
                color: charts.MaterialPalette.white
            ),
            lineStyle: charts.LineStyleSpec(
                thickness: 0,
                color: charts.MaterialPalette.white
            )
        )
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Text("Avance de puntos por mes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            ),
          ),
          SizedBox(
            height: 180.0,
            child: charts.LineChart(
              series,
              animate: true,
              primaryMeasureAxis: axis,
              domainAxis: axis,
              defaultRenderer: charts.LineRendererConfig(
                includePoints: true,
              )
            ),
          ),
        ],
      )
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Center(
            child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(userProfile.profileImageUrl)
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
                    ]
                ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            userProfile.fullName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.w800
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            userProfile.email,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Tienes ${userProfile.points} puntos',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 18.0,
              fontWeight: FontWeight.w800
            ),
          ),
          chartWidget
        ],
      )
    );
  }
}