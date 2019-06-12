import 'package:flutter/material.dart';
import 'package:helth_exercises_app/api/health_api.dart';

class ProfileView extends StatefulWidget {
  @override
  State createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  final HealthApi _healthApi = HealthApi();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Perfil",
        style: TextStyle(
            color: Colors.white,
            fontSize: 30.0
        ),
      ),
    );
  }
}