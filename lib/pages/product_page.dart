import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List arguments = Get.arguments;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: kStoreFrontBackgroundImage,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              //BACK BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  //BACK BUTTON
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: kBackButtonWidth,
                      height: kBackButtonHeight,
                      decoration: BoxDecoration(
                          color: kBackButtonBackgroundColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.arrow_back,
                        color: kMainColor,
                        size: kBackButtonSize,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        arguments[0],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            shadows: [
                              Shadow(
                                  color: kBorderAndShadowColors,
                                  blurRadius: 15),
                            ],
                            color: kProductTitleColor,
                            fontSize: kProductTitleFontSize,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              const SizedBox(
                height: 5,
              ),
              //PRODUCT IMAGE CONTAINER
              Material(
                elevation: 30,
                shadowColor: kProductMaterialShadowColor,
                color: kProductMaterialBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: kBorderAndShadowColors,
                    width: 3,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                // Product Image
                // PRICE AND SKU TAGS
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    //PRICE TAG
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundColor: kProductAvatarBackgroundColor,
                          maxRadius: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Hero(
                              tag: arguments[6],
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: arguments[2],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Material(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: kBorderAndShadowColors,
                                width: 3,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.elliptical(0, 0),
                                bottomLeft: Radius.elliptical(60, 60),
                                bottomRight: Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${arguments[1]}€',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                    shadows: [
                                      Shadow(
                                          color: kPriceShadowColor,
                                          blurRadius: kPriceBlurRadius),
                                    ],
                                    color: kPriceTextColor,
                                    fontSize: kPriceFontSize,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //SKU TAG
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Material(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: kBorderAndShadowColors,
                                width: 3,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.elliptical(360, 360),
                                bottomLeft: Radius.elliptical(50, 50),
                                bottomRight: Radius.circular(60),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${arguments[3]}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                    shadows: [
                                      Shadow(
                                        color: kPriceShadowColor,
                                        blurRadius: kPriceBlurRadius,
                                      ),
                                    ],
                                    color: kPriceTextColor,
                                    fontSize: kSkuFontSize,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //PRODUCT DESCRIPTION
              Expanded(
                flex: 3,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  itemCount: 1,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          const BoxShadow(
                              color: Color(0xFF00263b), blurRadius: 15),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Text(
                            '${arguments[4]}',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.comfortaa(
                              fontSize: 20,
                              letterSpacing: 1,
                              height: 1.2,
                              wordSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
