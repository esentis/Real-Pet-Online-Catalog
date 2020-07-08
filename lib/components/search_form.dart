import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

var logger = new Logger();

// SEARCH PRODUCT WIDGET
class SearchForm extends StatefulWidget {
  SearchForm({this.leadingIconColor, this.leadingIconSize, this.leadingIcon});
  final Color leadingIconColor;
  final double leadingIconSize;
  final IconData leadingIcon;

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  bool _searching = false;
  bool _validateSearch = false;
  @override
  Widget build(BuildContext context) {
    var _searchTerm;
    var _controller = new TextEditingController();
    return ListTile(
      leading: Icon(
        widget.leadingIcon,
        color: widget.leadingIconColor,
        size: widget.leadingIconSize,
      ),
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
          child: Text(
            "Αναζήτηση",
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
      ),
      onTap: () {
        Alert(
            context: context,
            style: AlertStyle(
              alertBorder: OutlineInputBorder(
                gapPadding: 15,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(20),
                ),
              ),
              overlayColor: Color(0xFF00263b),
              buttonAreaPadding: EdgeInsets.only(top: 50),
              backgroundColor: Colors.transparent,
              titleStyle: GoogleFonts.comfortaa(
                color: Colors.white,
              ),
            ),
            title: "Αναζήτηση προϊόντος",
            content: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: TextField(
                controller: _controller,
                maxLength: 10,
                style: GoogleFonts.comfortaa(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                onChanged: (typed) {
                  _searchTerm = typed;
                },
                enabled: true,
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.search, color: Colors.blue),
                  hintText: 'Αναζήτηση',
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                cursorColor: Colors.red,
              ),
            ),
            buttons: [
              DialogButton(
                color: Colors.white,

                radius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.elliptical(5, 5)),
                child: Text(
                  "Αναζήτηση",
                  style: TextStyle(
                    color: Color(0xFF00263b),
                    fontSize: 20,
                  ),
                ),
              ),

            ]).show();
      },
    );
  }
}
