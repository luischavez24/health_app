import 'package:flutter/material.dart';
import 'package:helth_exercises_app/api/health_api.dart';
import 'package:helth_exercises_app/widgets/benefit_card.dart';

class BenefitView extends StatefulWidget {
  @override
  State createState() => BenefitViewState();
}

class BenefitViewState extends State<BenefitView> {
  final HealthApi _healthApi = HealthApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _healthApi.fetchBenefits(0, 20),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            final benefits = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: ListView.builder(
                  itemCount: benefits.length,
                  itemBuilder: (context, index) => BenefitsCard(benefits[index])
              ),
            );
          }
        } else if(snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}