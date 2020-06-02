import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../shop_logic.dart';
import 'general_widgets.dart';

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
                onPressed: () async {
                  setState(() {
                    if (_controller.text.isEmpty) {
                      _validateSearch = true;
                      snackBar(
                          duration: 4,
                          text: "Το πεδίο αναζήτησης δε μπορεί να είναι κενό",
                          title: "Προσοχή !",
                          iconData: FontAwesomeIcons.exclamationCircle,
                          iconColor: Colors.orange);
                    } else {
                      _validateSearch = false;
                      _searching = true;
                    }
                  });
                  // IF THE TEXT FIELD IS NOT EMPTY
                  if (!_validateSearch) {
                    // WE CHECK FOR THE RESPONSE TRUE = OK RESPONSE , FALSE = ERROR
                    var response = await searchProducts(_searchTerm);
                    // ASSIGNING THE RESULT OF THE CHECK
                    bool responseCheck = checkResponse(response);
                    // IF TRUE
                    if (responseCheck) {
                      // IF THERE ARE NO SUCH PRODUCTS THROW A DIALOG ALERT
                      if (response.length == 0) {
                        snackBar(
                            duration: 4,
                            text:
                                "Δέν βρέθηκαν προϊόντα με τα κριτήρια αναζήτησης",
                            title: "Ουπς !",
                            iconData: FontAwesomeIcons.sadCry,
                            iconColor: Colors.redAccent);
                      }
                      // ELSE GO THE SEARCH PAGE TO SHOW THE RESULTS
                      else {
                        Get.toNamed('/search', arguments: response);
                      }
                    }
                  }
                },
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
              )
            ]).show();
      },
    );
  }
}
