import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';

//A DIFFERENT RESULTS DESIGN

bool _loading = false;
var logger = new Logger();

// STOREFRONT'S CATEGORIES
class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid.count(
              crossAxisSpacing: 9,
              mainAxisSpacing: 8,
              crossAxisCount: 4,
              children: <Widget>[
                CategoryIcon(
                  text: 'Τροφή σκύλου',
                  categoryId: 2,
                  categoryIcon: FontAwesomeIcons.dog,
                  iconColor: Colors.white,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Τροφή γάτας',
                  categoryId: 1,
                  categoryIcon: FontAwesomeIcons.cat,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Grooming',
                  categoryId: 4,
                  categoryIcon: FontAwesomeIcons.cut,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Σαμπουάν',
                  categoryId: 3,
                  categoryIcon: FontAwesomeIcons.soap,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Μπωλ φαγητού',
                  categoryId: 7,
                  categoryIcon: Icons.fastfood,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Παιχνίδια',
                  categoryId: 10,
                  categoryIcon: Icons.toys,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Κόκκαλα',
                  categoryId: 6,
                  categoryIcon: FontAwesomeIcons.bone,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Βιταμίνες',
                  categoryId: 11,
                  categoryIcon: FontAwesomeIcons.tablets,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Πουλιά',
                  categoryId: 5,
                  categoryIcon: FontAwesomeIcons.dove,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Επαγγελματικά',
                  categoryId: 8,
                  categoryIcon: FontAwesomeIcons.userMd,
                  color: kMainColor,
                ),
                CategoryIcon(
                  text: 'Διάφορα',
                  categoryId: 9,
                  categoryIcon: FontAwesomeIcons.ellipsisH,
                  color: kMainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CATEGORIES' ICON
class CategoryIcon extends StatefulWidget {
  CategoryIcon({
    this.text,
    this.categoryId,
    this.color,
    this.categoryIcon,
    this.iconColor,
  });
  final String text;
  final int categoryId;
  final Color color;
  final IconData categoryIcon;
  final Color iconColor;

  @override
  _CategoryIconState createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  final List argumentsList = [];

  @override
  Widget build(BuildContext context) {
    argumentsList.add(widget.categoryId);
    argumentsList.add(widget.text);
    argumentsList.add(widget.categoryIcon);
    return ModalProgressHUD(
      progressIndicator: SpinKitWave(
        color: kMainColor.withOpacity(0.8),
        size: 30.0,
      ),
      inAsyncCall: _loading,
      child: GestureDetector(
        onTap: () async {
          logger.i("Category tapped for search");
          Get.toNamed('/results', arguments: {
            "category": widget.categoryId,
            "lowestPrice": null,
            "highestPrice": null,
            "searchTerm": null,
          });
        },
        child: Material(
          color: widget.color,
          elevation: kCategoryElevation,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: kCategoryBorderWidth,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(500, 50),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.elliptical(50, 500),
            ),
          ),
          shadowColor: kBorderAndShadowColors,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    widget.categoryIcon,
                    color: widget.iconColor,
                    size: kCategoryIconSize,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        color: kCategoryTextColor,
                        fontSize: kCategoryTextFontSize,
                        fontWeight: FontWeight.w600),
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
