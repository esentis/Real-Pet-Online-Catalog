import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:realpet/components/animated_logo.dart';
import 'package:realpet/components/categories.dart';
import 'package:realpet/components/constants.dart';
import 'package:realpet/components/drawer.dart';
import 'package:realpet/components/modalsheet.dart';
import 'package:realpet/components/state_management.dart';

bool _loading = false;
var _currentUser;
FirebaseAuth auth = FirebaseAuth.instance;
FlareControls _controls = FlareControls();
var animationName = 'hamburger';
var logger = Logger();
// ignore: unused_element
String _displayName = 'No logged user';

class StoreFront extends StatefulWidget {
  @override
  _StoreFrontState createState() => _StoreFrontState();
}

class _StoreFrontState extends State<StoreFront>
    with SingleTickerProviderStateMixin {
  Future checkUser() async {
    _currentUser = await auth.currentUser();
    if (_currentUser == null) {
      logger.w('No authenticated user found, in the StoreFront');
      await Get.offAllNamed('/login');
      return;
    }
    // logger.i('${_currentUser.email ?? ''} is logged');
    // logger.i('${_currentUser.displayName ?? ''} is the display name');
    // logger.i('${_currentUser.providerId ?? ''} is the provider name');
    if (_currentUser.displayName == null) {
      _displayName = 'No display name specified';
    } else {
      _displayName = _currentUser.displayName;
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    var drawerModel = context.watch<DrawerModel>();
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: kStoreFrontBackgroundImage,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Scaffold(
            body: FoldableSidebarBuilder(
              drawer: CustomDrawer(
                currentUser: _currentUser,
                closeDrawer: () {
                  drawerModel.toggleDrawer();
                },
              ),
              screenContents: Column(
                children: <Widget>[
                  // MENU AND LOGO
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
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
                                border: const Border.fromBorderSide(BorderSide(
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
                        const RealPetLogo(
                          blurRadius: 10,
                          containerHeight: 150,
                          containerWidth: 200,
                          topRightRadius: Radius.circular(70),
                          topLeftRadius: Radius.circular(70),
                          bottomRightRadius: Radius.circular(20),
                          bottomLeftRadius: Radius.circular(20),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                  // ALL CATEGORIES
                  const SizedBox(
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
                shape: const StadiumBorder(
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
                        return ModalSheetSearch();
                      });
                }),
          ),
        ),
      ),
    );
  }
}
