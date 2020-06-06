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
import 'package:realpet/components/state_management.dart';
import 'package:realpet/components/search_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final drawerModel = context.watch<DrawerModel>();
    final bottomSearchModel = context.watch<BottomSearchModel>();
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Scaffold(
          body: FoldableSidebarBuilder(
            drawer: CustomDrawer(
              closeDrawer: () {
                drawerModel.toggleDrawer();
              },
            ),
            screenContents: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        drawerModel.toggleDrawer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff23374d),
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(BorderSide(
                              color: Color(0xFFce2e6c),
                              width: 3,
                            ))),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.cog,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
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
                Padding(
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
                            color: Color(0xff23374d),
                            letterSpacing: 0,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      textAlign: TextAlign.center,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
                Categories(),
              ],
            ),
            status: drawerModel.drawerStatus,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              elevation: 50,
              splashColor: Colors.redAccent,
              backgroundColor: Color(0xFF00263b),
              shape: StadiumBorder(
                side: BorderSide(
                  color: Color(0xFFce2e6c),
                  width: 3,
                ),
              ),
              child: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                if (drawerModel.drawerStatus == FSBStatus.FSB_OPEN) {
                  drawerModel.toggleDrawer();
                }
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Color(0xff00111b),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF00263b),
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
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
