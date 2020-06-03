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
    return Expanded(
      flex: 7,
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(30),
            sliver: SliverGrid.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              children: <Widget>[
                CategoryIcon(
                  text: 'Τροφή σκύλου',
                  categoryId: 2,
                  categoryIcon: FontAwesomeIcons.dog,
                  iconColor: Colors.white,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Τροφή γάτας',
                  categoryId: 1,
                  categoryIcon: FontAwesomeIcons.cat,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Grooming',
                  categoryId: 4,
                  categoryIcon: FontAwesomeIcons.cut,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Σαμπουάν',
                  categoryId: 3,
                  categoryIcon: FontAwesomeIcons.soap,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Μπωλ φαγητού',
                  categoryId: 7,
                  categoryIcon: Icons.fastfood,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Παιχνίδια',
                  categoryId: 10,
                  categoryIcon: Icons.toys,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Κόκκαλα',
                  categoryId: 6,
                  categoryIcon: FontAwesomeIcons.bone,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Βιταμίνες',
                  categoryId: 11,
                  categoryIcon: FontAwesomeIcons.tablets,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Πουλιά',
                  categoryId: 5,
                  categoryIcon: FontAwesomeIcons.dove,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Επαγγελματικά',
                  categoryId: 8,
                  categoryIcon: FontAwesomeIcons.userMd,
                  color: Color(0xFF00a1ab),
                ),
                CategoryIcon(
                  text: 'Διάφορα',
                  categoryId: 9,
                  categoryIcon: FontAwesomeIcons.ellipsisH,
                  color: Color(0xFF00a1ab),
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
          _loading = true;
          setState(() {});
//          dynamic response = await getCategoryProducts(widget.categoryId);
//          dynamic response =
//              await searchProducts(page: 1,category: widget.categoryId);
          var response = await searchProducts(category:widget.categoryId,page: 1,term: "");
          logger.i(response);
          _loading = false;
          setState(() {});
          bool responseCheck = checkResponse(response);
          if (responseCheck) {
            Get.toNamed('/searchResults', arguments: response);
          }
        },
        child: Material(
          color: widget.color,
          elevation: 12,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFFf1d1d1),
              width: 3,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.elliptical(10, 90),
              bottomLeft: Radius.elliptical(10, 90),
              bottomRight: Radius.circular(100),
            ),
          ),
          shadowColor: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    widget.categoryIcon,
                    color: widget.iconColor,
                    size: 18,
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
