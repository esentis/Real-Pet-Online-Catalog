import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List arguments = Get.arguments;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 5,),
            //BACK BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 15,),
                //BACK BUTTON
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF00263b),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  arguments[0],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            //PRODUCT IMAGE CONTAINER
            Material(
              elevation: 20,
              shadowColor: Colors.white,
              color: Colors.white,
              shape: ContinuousRectangleBorder(
                  side: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(90),
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(90),
                  )),
              // Product Image
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 170,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: arguments[2],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // PRODUCT TITLE
            //PRODUCT DESCRIPTION
            Expanded(
              flex: 3,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                itemCount: 1,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right : 15.0,left:45.0),
                  child: Center(
                    child: Text(
                      '${arguments[4]}',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //PRODUCT DETAILS
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
////                    Flexible(
////                      child: DataTable(
////                        headingRowHeight: 55,
////                        horizontalMargin: 0,
////                        dataRowHeight: 45,
////                        columnSpacing: 18,
////                        dividerThickness: 3,
////                        columns: [
////                          DataColumn(
////                              label: Flexible(
////                            child: Text(
////                              'SKU',
////                              style: GoogleFonts.comfortaa(fontSize: 15),
////                            ),
////                          )),
////                          DataColumn(
////                              numeric: false,
////                              label: Flexible(
////                                child: Text(
////                                  'Αρχική',
////                                  style: GoogleFonts.comfortaa(fontSize: 15),
////                                ),
////                              )),
////                          DataColumn(
////                              numeric: false,
////                              label: Flexible(
////                                child: Text(
////                                  arguments[5].toString() == 'dogFood' ||
////                                          arguments[5].toString() == 'catFood'
////                                      ? '-20%'
////                                      : '-10%',
////                                  style: GoogleFonts.comfortaa(fontSize: 15),
////                                ),
////                              )),
////                          DataColumn(
////                              numeric: false,
////                              label: Flexible(
////                                child: Text(
////                                  '-10% \nμετρητοίς',
////                                  style: GoogleFonts.comfortaa(fontSize: 15),
////                                  textAlign: TextAlign.left,
////                                ),
////                              )),
////                          DataColumn(
////                              numeric: false,
////                              label: Flexible(
////                                child: Text(
////                                  'Λιανική',
////                                  style: GoogleFonts.comfortaa(
////                                    fontSize: 15,
////                                  ),
////                                ),
////                              )),
////                        ],
////                        rows: [
////                          DataRow(cells: [
////                            DataCell(Text(
////                              '${arguments[1].toString()}',
////                              style: GoogleFonts.comfortaa(
////                                  color: Colors.white, fontSize: 17),
////                            )),
////                            DataCell(
////                              Row(
////                                children: <Widget>[
////                                  Text(
////                                    '${arguments[1].toString()}',
////                                    style: GoogleFonts.comfortaa(
////                                        fontSize: 17, color: Colors.white),
////                                  ),
////                                  Icon(
////                                    Icons.euro_symbol,
////                                    size: 17,
////                                  )
////                                ],
////                              ),
////                            ),
////                            DataCell(
////                              Row(
////                                children: <Widget>[
////                                  Text(
////                                    '${arguments[1].toString()}',
////                                    style: GoogleFonts.comfortaa(
////                                        fontSize: 17, color: Colors.white),
////                                  ),
////                                  Icon(
////                                    Icons.euro_symbol,
////                                    size: 17,
////                                  )
////                                ],
////                              ),
////                            ),
////                            DataCell(
////                              Row(
////                                children: <Widget>[
////                                  Text(
////                                    '${arguments[1].toString()}',
////                                    style: GoogleFonts.comfortaa(
////                                        fontSize: 17, color: Colors.white),
////                                  ),
////                                  Icon(
////                                    Icons.euro_symbol,
////                                    size: 17,
////                                  )
////                                ],
////                              ),
////                            ),
////                            DataCell(
////                              Row(
////                                children: <Widget>[
////                                  Text(
////                                    '${arguments[1].toString()}',
////                                    style: GoogleFonts.comfortaa(
////                                        fontSize: 17, color: Colors.white),
////                                  ),
////                                  Icon(
////                                    Icons.euro_symbol,
////                                    size: 17,
////                                  )
////                                ],
////                              ),
////                            ),
////                          ])
////                        ],
////                      ),
////                    ),
//                  ],
//                )
          ],
        ),
      ),
    ));
  }
}
