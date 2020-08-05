import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

class DrawerModel extends ChangeNotifier {
  FSBStatus drawerStatus;
  void getStatus() => drawerStatus;
  DrawerModel({this.drawerStatus});
  void toggleDrawer() {
    if (drawerStatus == FSBStatus.FSB_CLOSE) {
      drawerStatus = FSBStatus.FSB_OPEN;
      print('OPENING');
      notifyListeners();
    } else {
      drawerStatus = FSBStatus.FSB_CLOSE;
      print('CLOSING');
      notifyListeners();
    }
  }
}

class ResultsContainerModel extends ChangeNotifier {
  Random random = Random();
  void getRandom() => random.nextDouble() * 100;
  double topLeft;
  double topRight;
  double bottomLeft;
  double bottomRight;
  Color color;
  void getTopLeft() => topLeft;
  void getTopRight() => topRight;
  void getBottomLeft() => bottomLeft;
  void getBottomRight() => bottomRight;
  void getColor() => color;

  void setColor(newColor) {
    color = newColor;
    notifyListeners();
  }

  void setTopLeft(value) {
    topLeft = value;
    topLeft.toDouble();
    notifyListeners();
  }

  void setTopRight(value) {
    topRight = value;
    topRight.toDouble();
    notifyListeners();
  }

  void setBottomLeft(value) {
    bottomLeft = value;
    bottomLeft.toDouble();
    notifyListeners();
  }

  void setBottomRight(value) {
    bottomRight = value;
    bottomRight.toDouble();
    notifyListeners();
  }
}

class BottomSearchModel extends ChangeNotifier {
  var textController = TextEditingController();
  var textValue;
  void getValue() => textValue;
  void getController() => textController;
  BottomSearchModel({this.textValue, this.textController});
  void setValue(value) {
    textValue = value;
    notifyListeners();
  }
}
