import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:helth_exercises_app/models/benefit.dart';

class BenefitDetailPage extends StatelessWidget {
  final Benefit benefit;

  BenefitDetailPage({Key key, this.benefit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointsNeeded = Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            "${this.benefit.points} puntos",
            style: TextStyle(
              color: Colors.green,
              fontSize: 17.0
            ),
          ),
        )
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Icon(
          LineIcons.gift,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        SizedBox(height: 11.0),
        Text(
          benefit.name,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 3, child: pointsNeeded)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(this.benefit.imageUrl),
              fit: BoxFit.cover,
            ),
          )
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      benefit.description,
      style: TextStyle(fontSize: 18.0),
    );

    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () => {},
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Text("CANJEAR PROMOCIÓN", style: TextStyle(color: Colors.white)),
        shape: SuperellipseShape(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      )
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}