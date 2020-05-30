import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

List products = [];

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: products[index]['img'],
                        ),
                      ),
                    ),
                    title: Text(
                      products[index]['name'],
                      style: GoogleFonts.comfortaa(fontSize: 17),
                    ),
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
