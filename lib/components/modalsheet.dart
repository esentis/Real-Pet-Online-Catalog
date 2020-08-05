import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realpet/components/state_management.dart';
import 'constants.dart';
import 'package:provider/provider.dart';

class ModalSheetSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bottomSearchModel = context.watch<BottomSearchModel>();
    return Material(
      color: kMainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (value) {
                    bottomSearchModel.setValue(value);
                  },
                  onSubmitted: (value) {
                    Get.toNamed('/results', arguments: {
                      'category': null,
                      'lowestPrice': null,
                      'highestPrice': null,
                      'searchTerm': bottomSearchModel.textValue,
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Αναζήτηση προϊόντος',
                    enabled: true
                  ),
                  cursorWidth: 10,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  controller: bottomSearchModel.textController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(fontSize: 26),
                  autofocus: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
