import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:realpet/components/constants.dart';
import 'package:realpet/components/general_widgets.dart';

final TextEditingController _emailTextController = new TextEditingController();
final TextEditingController _passwordTextController =
    new TextEditingController();
bool _logging = false;
var _email;
var _password;
var _currentUser;
FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future checkUser() async {
    _currentUser = await _auth.currentUser();
    if (_currentUser != null) {
      print('User is logged, redirecting to StoreFront');
      Get.offAllNamed('/');
    } else {
      print('No user logged, log with your credentials');
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
      inAsyncCall: _logging,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: kStoreFrontBackgroundImage,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Material(
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
                          Container(
                            width: 200,
                            height: 120,
                            child: FlareActor(
                              'assets/logo.flr',
                              animation: 'idle',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Είσοδος χρήστη',
                        style: GoogleFonts.comfortaa(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          controller: _emailTextController,
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                          ),
                          onChanged: (email) {
                            print('Password value is $email');
                            _email = email;
                          },
                          cursorColor: Colors.red,
                          cursorRadius: Radius.circular(20),
                          enabled: true,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.user),
                            hintText: 'E-Mail',
                            hintStyle: GoogleFonts.comfortaa(
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              gapPadding: 15,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60),
                                bottomLeft: Radius.circular(60),
                              ),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordTextController,
                          onChanged: (password) {
                            print('Password value is $password');
                            _password = password;
                          },
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.red,
                          cursorRadius: Radius.circular(20),
                          enabled: true,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.lock),
                            hintText: 'Κωδικός',
                            hintStyle: GoogleFonts.comfortaa(
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              gapPadding: 15,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60),
                              ),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/register');
                            },
                            child: Text(
                              'Δεν είστε μέλος;\nΕγγραφή',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            child: Text(
                              'Είσοδος',
                              style: GoogleFonts.comfortaa(
                                  fontSize: 20, color: Colors.white),
                            ),
                            shape: StadiumBorder(),
                            onPressed: () async {
                              _logging = true;
                              setState(() {});
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _email,
                                  password: _password,
                                );
                              } catch (e) {
                                print(e);
                                _logging = false;
                                setState(() {
                                  snackBar(
                                      iconData: FontAwesomeIcons.times,
                                      iconColor: Colors.redAccent,
                                      text: e.toString(),
                                      duration: 4,
                                      title: 'Σφάλμα σύνδεσης');
                                });
                              }
                              _logging = false;
                              setState(() {});
                              if (await FirebaseAuth.instance.currentUser() !=
                                  null) {
                                Get.offAllNamed('/');
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
