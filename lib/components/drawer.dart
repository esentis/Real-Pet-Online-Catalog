import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:realpet/components/search_form.dart';

import 'package:realpet/pages/storefront.dart';
import 'general_widgets.dart';

class CustomDrawer extends StatefulWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

StoreFront sf = new StoreFront();

class _CustomDrawerState extends State<CustomDrawer> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Container(
        width: mediaQuery.size.width * 0.60,
        height: mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
              radius: 60,
            ),
            DrawerTile(text: "Προφίλ",icon: FontAwesomeIcons.userEdit,),
            SearchForm(
              leadingIcon: FontAwesomeIcons.search,
              leadingIconColor: Colors.red,
              leadingIconSize: 30,
            ),
            DrawerTile(text: "Αποσύνδεση",icon: FontAwesomeIcons.signOutAlt,onTapped: () async{
              _loading = true;
              setState(() {});
              await FirebaseAuth.instance.signOut();
              _loading = false;
              setState(() {});
              Get.offAllNamed('/login');
            },),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  DrawerTile({
    this.onTapped,
    this.text,
    this.icon,
  });
  final Function onTapped;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapped,
      leading: Icon(
        icon,
        color: Colors.redAccent,
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
