import 'package:flutter/cupertino.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

class DrawerModel extends ChangeNotifier{
  FSBStatus drawerStatus;
  getStatus()=>drawerStatus;
  DrawerModel({this.drawerStatus});
  toggleDrawer(){
    if(drawerStatus==FSBStatus.FSB_CLOSE){
      drawerStatus=FSBStatus.FSB_OPEN;
      print("OPENING");
      notifyListeners();
    }else{
      drawerStatus=FSBStatus.FSB_CLOSE;
      print("CLOSING");
      notifyListeners();
    }
  }
}

class BottomSearchModel extends ChangeNotifier {
  var textController = new TextEditingController();
  var textValue;
  getValue()=>textValue;
  getController()=>textController;
  BottomSearchModel({this.textValue,this.textController});
  setValue(value){
    textValue=value;
    notifyListeners();
  }
}