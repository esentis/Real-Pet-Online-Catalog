import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/constants.dart';
import 'package:realpet/components/modalsheet_edit_profile.dart';
import 'package:realpet/pages/storefront.dart';

var email;
var displayName;

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future checkUser() async {
    var _currentUser = await auth.currentUser();

    print(_currentUser.runtimeType);
    if (_currentUser == null) {
      logger.w('No authenticated user found, in the StoreFront');
      await Get.offAllNamed('/login');
    } else {
      logger.wtf('${_currentUser.email} is logged');
      logger.wtf('${_currentUser.displayName} is the display name');
      logger.wtf('${_currentUser.providerId} is the provider name');
//      await _currentUser
//          .updateEmail('esentakos@yahoo.gr')
//          .then(
//            (value) => print('Success'),
//          )
//          .catchError((onError) => print('error'));
//
//      var userUpdateInfo = UserUpdateInfo();
//      userUpdateInfo.displayName = 'esentis';
//      userUpdateInfo.photoUrl = 'url';
//      _currentUser
//          .updateProfile(userUpdateInfo)
//          .then((_) => print('Username changed'));
      if (_currentUser.displayName == null) {
        displayName = 'No display name specified';
      } else {
        displayName = _currentUser.displayName;
        email = _currentUser.email;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: kStoreFrontBackgroundImage,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
        fit: BoxFit.cover,
      )),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Edit profile',
                    style: GoogleFonts.gfsNeohellenic(
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'Tap for edit',
                    style: GoogleFonts.gfsNeohellenic(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfo(
                    text: 'Display name: $displayName',
                    fieldName: 'displayName',
                  ),
                  UserInfo(
                    text: 'Email: $email',
                    fieldName: 'email',
                  ),
                  const UserInfo(
                    text: 'Change the password',
                    fieldName: 'password',
                  ),
                ],
              ),
              FlatButton(
                onPressed: () => Get.offNamed('/'),
                child: const Center(child: Text('Get Back')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({this.fieldName, this.text});
  final String fieldName;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return EditProfileModalSheet(
                editingField: fieldName,
              );
            });
      },
      child: Card(
        color: Colors.white,
        elevation: 15,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style:
                GoogleFonts.gfsNeohellenic(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
