import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:realpet/components/categories.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:realpet/components/drawer.dart';
import 'package:realpet/components/search_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realpet/components/spinning_button.dart';

bool _loading = false;
var _currentUser;
String _logoAnimation = 'idle';
final FlareControls _controls = FlareControls();
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
  ButtonState _buttonState = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: SafeArea(
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
                      SpinningButton(
                        onPress: () async {
                          setState(() {
                            _buttonState = ButtonState.loading;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            _buttonState = ButtonState.fail;
                          });
                        },
                        buttonState: _buttonState,
                        idleIcon: FontAwesomeIcons.sign,
                        idleText: "TEST",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(80, 80),
                        bottomRight: Radius.elliptical(20, 20),
                        topRight: Radius.elliptical(80, 80),
                        bottomLeft: Radius.elliptical(20, 20),
                      )),
                      elevation: 40,
                      shadowColor: Color(0xFFf1d1d1),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _logoAnimation = 'touch';
                                });
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  setState(() {
                                    _logoAnimation = 'idle';
                                  });
                                });
                              },
                              child: Container(
                                width: 200,
                                height: 120,
                                child: FlareActor(
                                  'assets/logo.flr',
                                  animation: _logoAnimation,
                                  controller: _controls,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurple[400],
              child: Icon(
                Icons.menu,
                color: Colors.white,
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
