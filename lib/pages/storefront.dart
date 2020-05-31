import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'shop_logic.dart';

ListView productsListView;
List<ListTile> productsListTiles;
bool searching = false;
bool initialised = false;
var currentUser;
String logoAnimation = 'idle';
final FlareControls controls = FlareControls();
FirebaseAuth _auth = FirebaseAuth.instance;
var db = Firestore.instance;

class StoreFront extends StatefulWidget {
  @override
  _StoreFrontState createState() => _StoreFrontState();
}

class _StoreFrontState extends State<StoreFront>
    with SingleTickerProviderStateMixin {
  Future checkUser() async {
    currentUser = await _auth.currentUser();
    if (currentUser == null) {
      print('No authenticated user found, in the StoreFront');
      Get.offAllNamed('/login');
    } else {
      print('${currentUser.email} is logged');
//      getConnection();
//    await testDbB();
//      getProducts();
//      postHttp();
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: searching,
      child: Scaffold(
        body: SafeArea(
          child: Center(
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
                    SearchForm()
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
                                logoAnimation = 'touch';
                              });
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                setState(() {
                                  logoAnimation = 'idle';
                                });
                              });
                            },
                            child: Container(
                              width: 270,
                              height: 170,
                              child: FlareActor(
                                'assets/logo.flr',
                                animation: logoAnimation,
                                controller: controls,
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
                Row(
                  children: [
                    FlatButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/login');
                      },
                      child: Text('LOGOUT'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        searching = true;
                        setState(() {});
                        List products = await getProducts();
                        print(products);
                        searching = false;
                        setState(() {});
                        Get.toNamed('/test', arguments: products);
                      },
                      child: Text('TEST'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        searching = true;
                        setState(() {});
                        List products = await getCategoryProducts(3);
                        print(products);
                        searching = false;
                        setState(() {});
                        Get.toNamed('/test2', arguments: products);
                      },
                      child: Text('TEST 2'),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: FadeAnimatedTextKit(
                        onTap: () {
                          print("Animated text tap event");
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
        ),
      ),
    );
  }
}
