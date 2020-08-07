import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key, this.closeDrawer,this.currentUser})
      : super(key: key);
  final Function closeDrawer;
  final currentUser;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Container(
        width: mediaQuery.size.width * 0.60,
        height: mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
                shadowColor: Colors.white,
                color: Colors.white,
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.currentUser.displayName,
                      style: GoogleFonts.gfsNeohellenic(
                          fontSize: 30, color: Colors.black),
                    ),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/user',arguments: widget.currentUser),
              child: const DrawerTile(
                text: 'Προφίλ',
                icon: FontAwesomeIcons.userEdit,
                iconSize: 30,
              ),
            ),
            DrawerTile(
              text: 'Αποσύνδεση',
              icon: FontAwesomeIcons.signOutAlt,
              iconSize: 30,
              onTapped: () async {
                _loading = true;
                setState(() {});
                await FirebaseAuth.instance.signOut();
                _loading = false;
                setState(() {});
                await Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.onTapped, this.text, this.icon, this.iconSize});
  final Function onTapped;
  final String text;
  final IconData icon;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapped,
      leading: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Text(
            text,
            style: GoogleFonts.comfortaa(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
