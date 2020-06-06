import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

class DrawerModel extends ChangeNotifier {
  FSBStatus drawerStatus;
  getStatus() => drawerStatus;
  DrawerModel({this.drawerStatus});
  toggleDrawer() {
    if (drawerStatus == FSBStatus.FSB_CLOSE) {
      drawerStatus = FSBStatus.FSB_OPEN;
      print("OPENING");
      notifyListeners();
    } else {
      drawerStatus = FSBStatus.FSB_CLOSE;
      print("CLOSING");
      notifyListeners();
    }
  }
}

class ResultsContainerModel extends ChangeNotifier {
//  ResultsContainerModel({
//    this.bottomLeft,
//    this.bottomRight,
//    this.topRight,
//    this.topLeft,
//  });
  Random random = new Random();
  getRandom() => ((random.nextDouble() * 100));
  double topLeft;
  double topRight;
  double bottomLeft;
  double bottomRight;
  Color color;
  getTopLeft() => topLeft;
  getTopRight() => topRight;
  getBottomLeft() => bottomLeft;
  getBottomRight() => bottomRight;
  getColor()=>color;

  setColor(newColor){
    color=newColor;
    notifyListeners();
  }

  setTopLeft(value) {
    topLeft = value;
    topLeft.toDouble();
    notifyListeners();
  }

  setTopRight(value) {
    topRight = value;
    topRight.toDouble();
    notifyListeners();
  }

  setBottomLeft(value) {
    bottomLeft = value;
    bottomLeft.toDouble();
    notifyListeners();
  }

  setBottomRight(value) {
    bottomRight = value;
    bottomRight.toDouble();
    notifyListeners();
  }


}

class BottomSearchModel extends ChangeNotifier {
  var textController = new TextEditingController();
  var textValue;
  getValue() => textValue;
  getController() => textController;
  BottomSearchModel({this.textValue, this.textController});
  setValue(value) {
    textValue = value;
    notifyListeners();
  }
}
