import 'package:flutter/material.dart';
import 'package:helth_exercises_app/views/home_view.dart';
import 'package:provider/provider.dart';

import 'notifiers/view_changer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          accentColor: Colors.deepOrange,
          fontFamily: 'NotoSansHK'
      ),
      home: ChangeNotifierProvider<ViewChanger>(
        builder: (_) => ViewChanger(0),
        child: HomeView(),
      ),
    );
  }
}