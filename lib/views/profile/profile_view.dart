import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helth_exercises_app/api/health_api.dart';
import 'package:helth_exercises_app/models/user_profile.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:helth_exercises_app/widgets/common.dart';

class ProfileView extends StatefulWidget {
  FirebaseUser user;
  String accessToken;
  ProfileView({this.user, this.accessToken });

  @override
  State createState() => ProfileViewState(user: user, accessToken: accessToken);
}

class ProfileViewState extends State<ProfileView> {
  FirebaseUser user;
  String accessToken;

  final HealthApi _healthApi = HealthApi();

  ProfileViewState({this.user, this.accessToken });

  Future<UserProfile> _buildUserProfile() async {

    return UserProfile(
        email: this.user.email,
        displayName: this.user.displayName,
        calories: await _healthApi.getCalories(accessToken),
        profileImageUrl: this.user.photoUrl
    );
  }

  Future<List<charts.Series<CaloriesHistory, int>>> _buildSeries() async {
    return [
      charts.Series<CaloriesHistory, int>(
          id: 'PointsPerMonth',
          colorFn: (_,__) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (CaloriesHistory pointsPerMonth, _) => pointsPerMonth.dayNumber,
          measureFn: (CaloriesHistory pointsPerMonth, _) => pointsPerMonth.calories,
          displayName: "Puntos al mes",
          data: await _healthApi.getCaloriesHistory(accessToken),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<UserProfile>(
      future: _buildUserProfile(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            final userProfile = snapshot.data;
            return _buildDisplayProfile(context, userProfile);
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

  Widget _buildDisplayProfile(BuildContext context, UserProfile userProfile){
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

    var chartWidget = FutureBuilder(
      future: _buildSeries(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            final series = snapshot.data;
            return Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    Text("Avance de calorias por mes",
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
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),
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
              userProfile.displayName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              userProfile.email,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'Ha quemado ${userProfile.calories.toStringAsFixed(0)} calorias',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800
              ),
              textAlign: TextAlign.center,
            ),
            chartWidget
          ],
        )
    );
  }
}