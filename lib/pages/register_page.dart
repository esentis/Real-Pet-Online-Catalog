import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

var _password;
var _email;
bool _registering = false;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _registering,
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
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Εγγραφή χρήστη',
                      style: GoogleFonts.comfortaa(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30),
                      child: TextField(
                        style: GoogleFonts.comfortaa(fontSize: 20),
                        onChanged: (email) {
                          print('Email value is $email');
                          _email = email;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                        style: GoogleFonts.comfortaa(
                          fontSize: 20,
                        ),
                        onChanged: (password) {
                          print('Password value is $password');
                          _password = password;
                        },
                        obscureText: true,
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
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: Text(
                            'Είστε ήδη μέλος;\nΕίσοδος',
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
                            'Εγγραφή',
                            style: GoogleFonts.comfortaa(
                                fontSize: 20, color: Colors.white),
                          ),
                          shape: StadiumBorder(),
                          onPressed: () async {
                            _registering = true;
                            setState(() {});
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _email,
                                password: _password,
                              );
                            } catch (e) {
                              _registering = false;
                              setState(() {
                                Get.snackbar(
                                  '', // title
                                  '', // message
                                  icon: Icon(Icons.error),
                                  titleText: Text(
                                    'Σφάλμα !',
                                    style: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: .5),
                                    ),
                                  ),
                                  messageText: Text(e.toString()),
                                  shouldIconPulse: true,
                                  onTap: (value) {
                                    print(value);
                                  },
                                  barBlur: 300,
                                  isDismissible: true,
                                  duration: Duration(seconds: 3),
                                );
                              });
                            }

                            _registering = false;
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
    );
  }
}