import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/pages/shop_logic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:transparent_image/transparent_image.dart';

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
            padding: EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
class CategoryIcon extends StatelessWidget {
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
  final List argumentsList = [];
  final IconData categoryIcon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    argumentsList.add(categoryId);
    argumentsList.add(text);
    argumentsList.add(categoryIcon);
    return GestureDetector(
      onTap: () async {
        print('tapped');
        List products = await getCategoryProducts(categoryId);
        print(products);
        Get.toNamed('/results', arguments: products);
      },
      child: Material(
        color: color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xFFf1d1d1),
            width: 5,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
                  categoryIcon,
                  color: iconColor,
                  size: 38,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SEARCH PRODUCT WIDGET
class SearchProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _sku;
    return GestureDetector(
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
            title: "Αναζήτηση προϊόντος με βάση τον κωδικό",
            content: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: TextField(
                maxLength: 10,
                style: GoogleFonts.comfortaa(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                onChanged: (typed) {
                  _sku = typed;
                },
                enabled: true,
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.fingerprint),
                  hintText: 'Κωδικός προϊόντος',
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15, fontWeight: FontWeight.w900),
                  border: OutlineInputBorder(
                    gapPadding: 15,
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
                onPressed: () {
                  Get.toNamed('/search', arguments: _sku);
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
      child: Icon(
        FontAwesomeIcons.search,
        size: 30,
      ),
    );
  }
}

// SEARCH RESULTS PAGE
class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}
// SEARCH RESULTS PAGE STATE
class _SearchResultsState extends State<SearchResults> {
  List products = [];
  @override
  void initState() {
    super.initState();
    products = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListView.builder(
              itemCount: products.length ?? 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ResultsTile(
                    categoryId: products[index]['categoryId'],
                    img: products[index]['img'],
                    desc: products[index]['description'],
                    originalPrice: products[index]['originalPrice'],
                    productName: products[index]['name'],
                    productSKU: products[index]['sku'],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// RESULTS' TILE
class ResultsTile extends StatelessWidget {
  ResultsTile({
    this.productName,
    this.originalPrice,
    this.productSKU,
    this.img,
    this.desc,
    this.categoryId,
  });
  final int categoryId;
  final String productName;
  final String productSKU;
  final double originalPrice;
  final String img;
  final String desc;
  @override
  Widget build(BuildContext context) {
    List argumentsList = [
      productName,
      originalPrice,
      img,
      productSKU,
      desc,
      categoryId
    ];
    return ListTile(
      onTap: () {
        Get.toNamed('/product', arguments: argumentsList);
      },
      leading: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: img,
          ),
        ),
      ),
      title: Text(
        '$productName',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        '$productSKU',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(),
      ),
      trailing: Text(
        '${originalPrice.toString()}€',
        style: GoogleFonts.comfortaa(
          fontSize: 18,
        ),
      ),
    );
  }
}
