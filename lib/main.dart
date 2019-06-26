import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helth_exercises_app/views/home_view.dart';
import 'package:helth_exercises_app/views/login_view.dart';
import 'package:provider/provider.dart';

import 'notifiers/user_repository.dart';
import 'notifiers/view_changer.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: ChangeNotifierProvider<UserRepository>(
        builder: (_) => UserRepository.instance(),
        child: Consumer(
          builder: (context, UserRepository user, _) {
            switch (user.status) {
              case Status.Uninitialized:
                return Splash();
              case Status.Unauthenticated:
              case Status.Authenticating:
                return LoginView();
              case Status.Authenticated:
                return _buildHome(user: user.user, accessToken: user.accessToken);
            }
          },
        ),
      ),
    );

  }


  Widget _buildHome ({ FirebaseUser user, String accessToken }) {
    return ChangeNotifierProvider<ViewChanger>(
      builder: (_) => ViewChanger(0),
      child: HomeView(user: user, accessToken: accessToken),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          accentColor: Colors.deepOrange,
          fontFamily: 'NotoSansHK'
      ),
      home: Scaffold(
        body: Center(
          child: Text("Splash Screen"),
        ),
      )
    );
  }
}