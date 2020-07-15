import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:realpet/components/animated_logo.dart';
import 'package:realpet/components/categories.dart';
import 'package:realpet/components/constants.dart';
import 'package:realpet/components/drawer.dart';
import 'package:realpet/components/state_management.dart';

bool _loading = false;
var _currentUser;
FirebaseAuth _auth = FirebaseAuth.instance;
var db = Firestore.instance;
FlareControls _controls = FlareControls();
var animationName = 'hamburger';
var logger = new Logger();

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

  @override
  Widget build(BuildContext context) {
    final drawerModel = context.watch<DrawerModel>();
    final bottomSearchModel = context.watch<BottomSearchModel>();
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: kStoreFrontBackgroundImage,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            body: FoldableSidebarBuilder(
              drawer: CustomDrawer(
                closeDrawer: () {
                  drawerModel.toggleDrawer();
                },
              ),
              screenContents: Column(
                children: <Widget>[
                  // MENU AND LOGO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // SETTINGS TOGGLER
                      GestureDetector(
                        onTap: () {
                          drawerModel.toggleDrawer();
                          setState(() {
                            if (animationName == 'toX') {
                              animationName = 'toHamburger';
                            } else {
                              animationName = 'toX';
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kMainColor,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(BorderSide(
                                color: Colors.white,
                                width: 3,
                              ))),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlareActor(
                              'assets/settings_icon.flr',
                              animation: animationName,
                              controller: _controls,
                              color: Colors.white,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      RealPetLogo(
                        blurRadius: 0,
                        containerHeight: 100,
                        containerWidth: 150,
                        topRightRadius: Radius.circular(0),
                        topLeftRadius: Radius.circular(60),
                        bottomRightRadius: Radius.circular(60),
                        bottomLeftRadius: Radius.circular(60),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  // ALL CATEGORIES
                  SizedBox(
                    height: 150,
                  ),
                  Categories(),
                ],
              ),
              status: drawerModel.drawerStatus,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                elevation: 50,
                splashColor: kSearchButtonSplashColor,
                backgroundColor: kMainColor,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.search,
                  color: kIconColor,
                  size: 40,
                ),
                onPressed: () {
                  if (drawerModel.drawerStatus == FSBStatus.FSB_OPEN) {
                    drawerModel.toggleDrawer();
                  }
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Material(
                          color: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Αναζήτηση προϊόντος",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                    fontSize: 26,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.redAccent,
                                          blurRadius: 15),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        bottomSearchModel.setValue(value);
                                      },
                                      onSubmitted: (value) {
                                        Get.toNamed('/results', arguments: {
                                          "category": null,
                                          "lowestPrice": null,
                                          "highestPrice": null,
                                          "searchTerm":
                                              bottomSearchModel.textValue,
                                        });
                                      },
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.search,
                                      controller:
                                          bottomSearchModel.textController,
                                      textAlign: TextAlign.center,
                                      style:
                                          GoogleFonts.comfortaa(fontSize: 26),
                                      autofocus: true,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Get.toNamed('/results', arguments: {
                                          "category": null,
                                          "lowestPrice": null,
                                          "highestPrice": null,
                                          "searchTerm":
                                              bottomSearchModel.textValue,
                                        });
                                      },
                                      color: Colors.red,
                                      child: Text("Αναζήτηση"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
