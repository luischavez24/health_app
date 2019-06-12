import 'package:flutter/material.dart';
import 'package:helth_exercises_app/notifiers/view_changer.dart';
import 'package:helth_exercises_app/views/exercises/exercise_view.dart';
import 'package:helth_exercises_app/views/benefits/benefits_view.dart';
import 'package:helth_exercises_app/views/profile/profile_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final List views = [
    {
      "view": BenefitView(),
      "bottomNav": BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
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
          icon: Icon(Icons.person),
          title: Text("Perfil")
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final viewChanger = Provider.of<ViewChanger>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: buildAppBar("Health Prix"),
      body: Container(
          child: views[viewChanger.viewIndex]["view"]
      ),
      bottomNavigationBar: buildBottom(viewChanger)
    );
  }

  Widget buildAppBar(String title) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
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