import 'package:flutter/material.dart';
import 'package:helth_exercises_app/notifiers/view_changer.dart';
import 'package:helth_exercises_app/views/exercises/exercise_view.dart';
import 'package:helth_exercises_app/views/benefits/benefit_view.dart';
import 'package:helth_exercises_app/views/profile/profile_view.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';

class HomeView extends StatelessWidget {
  final List views = [
    {
      "view": BenefitView(),
      "bottomNav": BottomNavigationBarItem(
          icon: Icon(LineIcons.gift),
          title: Text("Beneficios")
      ),
    },
    {
      "view": ExerciseView(),
      "bottomNav": BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          title: Text("Ejercicios")
      ),
    },
    {
      "view": ProfileView(),
      "bottomNav": BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          title: Text("Perfil")
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final viewChanger = Provider.of<ViewChanger>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: buildAppBar("Health Prix"),
      body: Container(
          child: views[viewChanger.viewIndex]["view"]
      ),
      bottomNavigationBar: buildBottom(viewChanger),
    );
  }

  Widget buildAppBar(String title) {
    return AppBar(
      elevation: 5.0,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Row(
        children: <Widget>[
          Icon(LineIcons.heartbeat),
          SizedBox(width: 5.0),
          Text(title)
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(LineIcons.search),
          onPressed: () {},
        )
      ],

    );
  }

  Widget buildBottom(ViewChanger viewChanger) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.deepOrangeAccent,
      items: List<BottomNavigationBarItem>.from(this.views.map((view) => view['bottomNav'])),
      onTap: viewChanger.changeView,
      currentIndex: viewChanger.viewIndex,
    );
  }
}