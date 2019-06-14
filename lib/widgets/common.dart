import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  String errorDetail;

  ErrorDisplay({ this.errorDetail });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Text(this.errorDetail,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}