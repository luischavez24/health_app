import 'package:flutter/material.dart';
import 'package:helth_exercises_app/api/health_api.dart';

class BenefitView extends StatefulWidget {
  @override
  State createState() => BenefitViewState();
}

class BenefitViewState extends State<BenefitView> {
  final HealthApi _healthApi = HealthApi();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Beneficios",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0
        ),
      ),
    );
  }
}