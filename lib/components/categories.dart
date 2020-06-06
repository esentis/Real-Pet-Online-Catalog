import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'file:///D:/Flutter_apps/real_pet/lib/shop_logic.dart';
import 'general_widgets.dart';

bool _loading = false;

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
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Τροφή γάτας',
                  categoryId: 1,
                  categoryIcon: FontAwesomeIcons.cat,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Grooming',
                  categoryId: 4,
                  categoryIcon: FontAwesomeIcons.cut,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Σαμπουάν',
                  categoryId: 3,
                  categoryIcon: FontAwesomeIcons.soap,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Μπωλ φαγητού',
                  categoryId: 7,
                  categoryIcon: Icons.fastfood,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Παιχνίδια',
                  categoryId: 10,
                  categoryIcon: Icons.toys,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Κόκκαλα',
                  categoryId: 6,
                  categoryIcon: FontAwesomeIcons.bone,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Βιταμίνες',
                  categoryId: 11,
                  categoryIcon: FontAwesomeIcons.tablets,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Πουλιά',
                  categoryId: 5,
                  categoryIcon: FontAwesomeIcons.dove,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Επαγγελματικά',
                  categoryId: 8,
                  categoryIcon: FontAwesomeIcons.userMd,
                  color: Color(0xff23374d),
                ),
                CategoryIcon(
                  text: 'Διάφορα',
                  categoryId: 9,
                  categoryIcon: FontAwesomeIcons.ellipsisH,
                  color: Color(0xff23374d),
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
        color: Color(0xFF00263b).withOpacity(0.8),
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
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFFce2e6c),
              width: 3,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.elliptical(60, 60),
              bottomLeft: Radius.elliptical(60, 60),
              bottomRight: Radius.circular(60),
            ),
          ),
          shadowColor: Color(0xFFce2e6c),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    widget.categoryIcon,
                    color: widget.iconColor,
                    size: 31,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontSize: 10,
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
