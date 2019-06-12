import 'package:flutter/material.dart';

class ViewChanger with ChangeNotifier {
  int _viewIndex;

  ViewChanger(this._viewIndex);

  int get viewIndex => this._viewIndex;

  void changeView(int newViewId) {
    this._viewIndex = newViewId;
    notifyListeners();
  }
}