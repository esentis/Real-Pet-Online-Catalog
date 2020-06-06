import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:realpet/components/animated_logo.dart';
import 'package:realpet/components/drawer.dart';
import 'package:realpet/components/general_widgets.dart';
import 'package:realpet/components/spinning_button.dart';

import '../shop_logic.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

var startingRanges = RangeValues(0.0, 300);
double startingPrice=0;
double endingPrice=0;
class _SearchPageState extends State<SearchPage> {
  String _logoAnimation = "idle";
  final FlareControls _controls = FlareControls();
  final _textController = new TextEditingController();
  var _searchTerm;
  bool _searching = false;
  ButtonState _buttonState = ButtonState.idle;
  bool _validateSearch = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed('/');
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.home,
                          color: Color(0xFF00263b),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "LOGO",
                    child: Container(
                      width: 150,
                      height: 90,
                      child: FlareActor(
                        'assets/logo.flr',
                        animation: _logoAnimation,
                        controller: _controls,
                        color: Colors.white,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Προϊόντα απο ${startingPrice.floor()}€ μέχρι ${endingPrice.floor()}€",
                    style: GoogleFonts.comfortaa(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    onChanged: (newStartingPrice) {
                      setState(() {
                        startingPrice = newStartingPrice;
                        if (startingPrice>endingPrice){
                          endingPrice=startingPrice;
                        }
                      });
                    },
                    min: 0,
                    max: 300,
                    value: startingPrice,
                  ),
                  Slider(
                    onChanged: (newEndingPrice) {
                      setState(() {
                        endingPrice = newEndingPrice;
                        if (endingPrice<startingPrice){
                          startingPrice=endingPrice;
                        }
                      });
                    },
                    min: 0,
                    max: 300,
                    value: endingPrice,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 23.0, left: 23.0),
                    child: TextField(
                      maxLength: 10,
                      controller: _textController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Αναζήτηση προϊόντος',
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
                      onChanged: (value) {
                        _searchTerm = value;
                        print(value);
                      },
                    ),
                  ),
                  FlatButton(onPressed: () async{
                    _buttonState = ButtonState.loading;
                    setState(() {
                        if (_textController.text.isEmpty) {
                          _validateSearch = true;
                          snackBar(
                              duration: 4,
                              text:
                                  "Το πεδίο αναζήτησης δε μπορεί να είναι κενό",
                              title: "Προσοχή !",
                              iconData: FontAwesomeIcons.exclamationCircle,
                              iconColor: Colors.orange);
                          _buttonState = ButtonState.fail;
                        } else {
                          _validateSearch = false;
                          _searching = true;
                        }
                      _validateSearch = false;
                      _searching = true;
                    });
                    if (_buttonState == ButtonState.fail) {
                      await Future.delayed(const Duration(milliseconds: 4000),
                              () {
                            setState(() {
                              _buttonState = ButtonState.idle;
                            });
                          });
                    }
                    // IF THE TEXT FIELD IS NOT EMPTY
                      // WE CHECK FOR THE RESPONSE TRUE = OK RESPONSE , FALSE = ERROR
                      var response =
                          await searchProducts(term: _searchTerm, page: 1);
                      Get.toNamed('/results', arguments: {
                        "category": null,
                        "lowestPrice": startingPrice,
                        "highestPrice": endingPrice,
                        "searchTerm": _searchTerm,
                      });
                  },child: Text("FLAT BUTTON"),),
//                  SpinningButton(
//                    onPress: () async {
//                      _buttonState = ButtonState.loading;
//                        setState(() {
////                        if (_textController.text.isEmpty) {
////                          _validateSearch = true;
////                          snackBar(
////                              duration: 4,
////                              text:
////                                  "Το πεδίο αναζήτησης δε μπορεί να είναι κενό",
////                              title: "Προσοχή !",
////                              iconData: FontAwesomeIcons.exclamationCircle,
////                              iconColor: Colors.orange);
////                          _buttonState = ButtonState.fail;
////                        } else {
////                          _validateSearch = false;
////                          _searching = true;
////                        }
//                          _validateSearch = false;
//                          _searching = true;
//                        });
//                        if (_buttonState == ButtonState.fail) {
//                          await Future.delayed(const Duration(milliseconds: 4000),
//                                  () {
//                                setState(() {
//                                  _buttonState = ButtonState.idle;
//                                });
//                              });
//                        }
//                        // IF THE TEXT FIELD IS NOT EMPTY
//                        if (!_validateSearch) {
//                          // WE CHECK FOR THE RESPONSE TRUE = OK RESPONSE , FALSE = ERROR
//                          var response =
//                              await searchProducts(term: _searchTerm, page: 1);
//                          // ASSIGNING THE RESULT OF THE CHECK
//                          bool responseCheck = checkResponse(response);
//                          // IF TRUE
//                          if (responseCheck) {
//                            // IF THERE ARE NO SUCH PRODUCTS THROW A DIALOG ALERT
//                            if (response.length == 0) {
//                              snackBar(
//                                  duration: 4,
//                                  text:
//                                  "Δέν βρέθηκαν προϊόντα με τα κριτήρια αναζήτησης",
//                                  title: "Ουπς !",
//                                  iconData: FontAwesomeIcons.sadCry,
//                                  iconColor: Colors.redAccent);
//                            }
//                            // ELSE GO THE SEARCH PAGE TO SHOW THE RESULTS
//                            else {
//                              setState(() {
//                                _buttonState = ButtonState.idle;
//                              });
//                              Get.toNamed('/results', arguments: {
//                                "category": null,
//                                "lowestPrice": startingRanges.start,
//                                "highestPrice": startingRanges.end,
//                                "searchTerm": _searchTerm,
//                              });
//                            }
//                          }
//                        setState(() {
//                          _buttonState = ButtonState.fail;
//                        });
//                        if (_buttonState == ButtonState.fail) {
//                          await Future.delayed(
//                              const Duration(milliseconds: 4000), () {
//                            setState(() {
//                              _buttonState = ButtonState.idle;
//                            });
//                          });
//                        }
//                      }
//                    },
//                    buttonState: _buttonState,
//                    idleIcon: FontAwesomeIcons.search,
//                    idleText: "ΑΝΑΖΗΤΗΣΗ",
//                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
