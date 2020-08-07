import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/state_management.dart';
import 'package:realpet/pages/storefront.dart';
import 'constants.dart';
import 'package:provider/provider.dart';

class EditProfileModalSheet extends StatelessWidget {
  const EditProfileModalSheet({this.editingField});
  final String editingField;

  String checkField() {
    if (editingField == 'displayName') {
      return 'Edit the display name';
    } else if (editingField == 'email') {
      return 'Edit the email address';
    } else if (editingField == 'password') {
      return 'Add new password';
    } else if (editingField == null) {
      return 'Page needs refresh';
    }
    return 'Hmm';
  }

  Future<void> saveChanges(String value) async {
    var _currentUser = await auth.currentUser();
    var userUpdateInfo = UserUpdateInfo();

    if (editingField == 'displayName') {
      userUpdateInfo.displayName = value;
      await _currentUser
          .updateProfile(userUpdateInfo)
          .then((_) => print('Display name changed'))
          .catchError((onError) => print('error changing display name'));
    } else if (editingField == 'email') {
      await _currentUser
          .updateEmail(value)
          .then(
            (value) => print('Email has changed'),
          )
          .catchError((onError) => print('error changing email'));
    } else if (editingField == 'password') {
      await _currentUser
          .updatePassword(value)
          .then(
            (value) => print('Password has changed'),
          )
          .catchError((onError) => print('error changing password'));
    } else if (editingField == null) {
      return 'Page needs refresh';
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottomSearchModel = context.watch<BottomSearchModel>();
    return Material(
      color: kMainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (value) {
                    bottomSearchModel.setValue(value);
                  },
                  onSubmitted: (value) {
                    saveChanges(value);
                  },
                  decoration:
                      InputDecoration(hintText: checkField(), enabled: true),
                  cursorWidth: 10,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: bottomSearchModel.textController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(fontSize: 26),
                  autofocus: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
