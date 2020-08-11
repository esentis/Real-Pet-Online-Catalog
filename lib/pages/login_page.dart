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

final TextEditingController _emailTextController = TextEditingController();
final TextEditingController _passwordTextController = TextEditingController();
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
      logger.i('User is logged, redirecting to StoreFront');
      await Get.offAllNamed('/');
    } else {
      logger.w('No user logged, log with your credentials');
    }
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
      child: ModalProgressHUD(
        inAsyncCall: _logging,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(80, 80),
                      bottomRight: Radius.elliptical(20, 20),
                      topRight: Radius.elliptical(80, 80),
                      bottomLeft: Radius.elliptical(20, 20),
                    )),
                    elevation: 40,
                    shadowColor: const Color(0xFFf1d1d1),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 200,
                            height: 120,
                            child: const FlareActor(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          controller: _emailTextController,
                          style: GoogleFonts.comfortaa(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          onChanged: (email) {
                            logger.i('Password value is $email');
                            _email = email;
                          },
                          cursorColor: Colors.red,
                          cursorRadius: const Radius.circular(20),
                          enabled: true,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: const Icon(FontAwesomeIcons.user),
                            hintText: 'E-Mail',
                            hintStyle: GoogleFonts.comfortaa(
                                fontSize: 20, color: Colors.black),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordTextController,
                          onChanged: (password) {
                            logger.i('Password value is $password');
                            _password = password;
                          },
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                          ),
                          cursorColor: Colors.red,
                          cursorRadius: const Radius.circular(20),
                          enabled: true,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            icon: const Icon(FontAwesomeIcons.lock),
                            hintText: 'Κωδικός',
                            hintStyle: GoogleFonts.comfortaa(
                                fontSize: 20, color: Colors.white),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
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
                          const SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            color: Colors.white,
                            child: Text(
                              'Είσοδος',
                              style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            shape: const StadiumBorder(),
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
                                logger.e(e);
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
                                await Get.offAllNamed('/');
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
