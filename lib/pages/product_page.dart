import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List finalPrices = Get.arguments[1];
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //STYLING PRICE AND SKU
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //BACK BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                //PRODUCT IMAGE CONTAINER
                Material(
                  elevation: 20,
                  shadowColor: Colors.white,
                  color: Colors.white,
                  shape: ContinuousRectangleBorder(
                      side: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 10,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(500),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(500),
                        bottomLeft: Radius.circular(0),
                      )),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: Get.arguments[2],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Text(
                    Get.arguments[0],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          '${Get.arguments[4]}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                            fontSize: 17,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: DataTable(
                          headingRowHeight: 55,
                          horizontalMargin: 0,
                          dataRowHeight: 45,
                          columnSpacing: 25,
                          dividerThickness: 3,
                          columns: [
                            DataColumn(
                                label: Flexible(
                              child: Text(
                                'SKU',
                                style: GoogleFonts.comfortaa(fontSize: 15),
                              ),
                            )),
                            DataColumn(
                                numeric: false,
                                label: Flexible(
                                  child: Text(
                                    'Αρχική',
                                    style: GoogleFonts.comfortaa(fontSize: 15),
                                  ),
                                )),
                            DataColumn(
                                numeric: false,
                                label: Flexible(
                                  child: Text(
                                    '-10%',
                                    style: GoogleFonts.comfortaa(fontSize: 15),
                                  ),
                                )),
                            DataColumn(
                                numeric: false,
                                label: Flexible(
                                  child: Text(
                                    '-10% \nμετρητοίς',
                                    style: GoogleFonts.comfortaa(fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                )),
                            DataColumn(
                                numeric: false,
                                label: Flexible(
                                  child: Text(
                                    'Λιανική',
                                    style: GoogleFonts.comfortaa(fontSize: 15,),
                                  ),
                                )),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('${Get.arguments[3]}',
                              style: GoogleFonts.comfortaa(
                                color: Colors.white,
                                fontSize: 17
                              ),)),
                              DataCell(Row(
                                children: <Widget>[
                                  Text(
                                    '${finalPrices[0]}',
                                    style:
                                    GoogleFonts.comfortaa(fontSize: 17,
                                    color: Colors.white),
                                  ),
                                  Icon(Icons.euro_symbol,size: 17,)
                                ],
                              ),),
                              DataCell(
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${finalPrices[1]}',
                                      style:
                                          GoogleFonts.comfortaa(fontSize: 17,
                                          color : Colors.white),
                                    ),
                                    Icon(Icons.euro_symbol,size: 17,)
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${finalPrices[2]}',
                                      style:
                                          GoogleFonts.comfortaa(fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    Icon(Icons.euro_symbol,size: 17,)
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${finalPrices[3]}',
                                      style:
                                          GoogleFonts.comfortaa(fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    Icon(Icons.euro_symbol,size: 17,)
                                  ],
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
