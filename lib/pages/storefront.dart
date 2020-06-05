import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realpet/components/animated_logo.dart';
import 'package:realpet/components/categories.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:realpet/components/drawer.dart';
import 'package:realpet/components/search_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool _loading = false;
var _currentUser;
FirebaseAuth _auth = FirebaseAuth.instance;
var db = Firestore.instance;

class StoreFront extends StatefulWidget {
  @override
  _StoreFrontState createState() => _StoreFrontState();
}

class _StoreFrontState extends State<StoreFront>
    with SingleTickerProviderStateMixin {
  Future checkUser() async {
    _currentUser = await _auth.currentUser();
    if (_currentUser == null) {
      logger.i('No authenticated user found, in the StoreFront');
      Get.offAllNamed('/login');
    } else {
      logger.i('${_currentUser.email} is logged');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  FSBStatus drawerStatus;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Scaffold(
          body: FoldableSidebarBuilder(
            drawerBackgroundColor: Color(0xFF00263b),
            drawer: CustomDrawer(
              closeDrawer: () {
                setState(() {
                  drawerStatus = FSBStatus.FSB_CLOSE;
                });
              },
            ),
            screenContents: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  AnimatedLogo(
                    height: 100,
                    width: 150,
                    elevation: 40,
                    bottomLeftRadius: Radius.elliptical(20, 20),
                    bottomRightRadius: Radius.elliptical(20, 20),
                    topLeftRadius: Radius.elliptical(80, 80),
                    topRightRadius: Radius.elliptical(80, 80),
                    backGroundColor: Colors.white,
                    logoColor: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                    onPressed: () {
                      Get.toNamed('/search');
                    },
                    child: Text("PRESS ME"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child: FadeAnimatedTextKit(
                          onTap: () {
                            logger.i("Animated text tap event");
                          },
                          text: [
                            "Μεγάλη ποικιλία προϊόντων",
                            "Όλα για τους μικρούς μας φίλους",
                            "Real Pet χονδρική"
                          ],
                          textStyle: GoogleFonts.comfortaa(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional
                              .topStart // or Alignment.topLeft
                          ),
                    ),
                  ),
                  Categories(),
                ],
              ),
            ),
            status: drawerStatus,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            elevation: 50,
              splashColor: Colors.redAccent,
              backgroundColor: Color(0xFF00263b),
              shape: StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 3)),
              child: Icon(
                FontAwesomeIcons.ellipsisH,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                logger.i(drawerStatus);
                setState(() {
                  drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                      ? FSBStatus.FSB_CLOSE
                      : FSBStatus.FSB_OPEN;
                });
              }),
        ),
      ),
    );
  }
}
