import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:realpet/components/general_widgets.dart';

var logger = new Logger();
// CONNECTION SETTINGS WITH OUR DB
BaseOptions dioOptions = new BaseOptions(
    baseUrl: "http://10.0.2.2:5000",
    receiveDataWhenStatusError: true,
    connectTimeout: 6 * 1000, // 6 seconds
    receiveTimeout: 6 * 1000 // 6 seconds
    );
Dio dio = new Dio(dioOptions);

// METHOD FOR RETRIEVING ALL PRODUCTS
getProducts() async {
  Response response;
  try {
    response = await dio.get("/api/product");
    print(response.statusCode);
    print(response.data.length);
  } on DioError catch (e) {
    return e.type;
  }
  return response.data;
}

// METHOD FOR RETRIEVING ALL PRODUCTS ON A SPECIFIC CATEGORY
getCategoryProducts(categoryId) async {
  Response response;
  try {
    response = await dio.get("/api/product/category/$categoryId");
    print(response.statusCode);
    print(response.data.length);
  } on DioError catch (e) {
    return e.type;
  }
  return response.data;
}

// METHOD FOR SEARCHING PRODUCTS
searchProducts({term, page, category, lowestPrice, highestPrice}) async {
  Response response;
  FormData formData = new FormData.fromMap({
    "page": page,
    "category": category,
    "lowestPrice": lowestPrice,
    "highestPrice": highestPrice,
    "searchTerm": term,
  });
  try {
    response = await dio.post("/api/product/search", data: formData);
  } on DioError catch (e) {
    return e.type;
  }

  return response.data;
}

// METHOD FOR ADDING A NEW PRODUCT
addProduct({
  @required int categoryId,
  @required String name,
  @required String img,
  @required double originalPrice,
  @required double sellingPrice,
  @required String description,
  @required String sku,
}) async {
  Response response;
  try {
    response = await dio.post("/api/product", data: {
      "categoryId": categoryId,
      "name": name,
      "img": img,
      "originalPrice": originalPrice,
      "sellingPrice": sellingPrice,
      "sku": sku,
      "description": description,
    });
    print(response);
  } on DioError catch (e) {
    return e.type;
  }
  return response;
}

// METHOD THAT RESPONDS TO SERVER ERRORS
bool checkResponse(response) {
  if (response == DioErrorType.CONNECT_TIMEOUT) {
    logger.e("Received ERROR $response");
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: "Η σύνδεση με τον διακομιστή απέτυχε",
      title: "Σφάλμα",
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.RECEIVE_TIMEOUT) {
    logger.e("Received ERROR $response");
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: "Η απάντηση του διακομιστή απέτυχε",
      title: "Σφάλμα",
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.RESPONSE) {
    logger.e("Received ERROR $response");
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: "Λανθασμένη απάντηση του διακομιστή",
      title: "Σφάλμα",
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.CANCEL) {
    logger.e("Received ERROR $response");
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: "Η κλήση προς τον διακομιστή ακυρώθηκε",
      title: "Σφάλμα",
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.DEFAULT) {
    logger.e("Received ERROR $response");
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: "Άγνωστο σφάλμα διακομιστή",
      title: "Σφάλμα",
      duration: 3,
    );
    return false;
  }
  return true;
}

// A METHOD FOR COPYING MY FIREBASE TO postgresql
// IT'S NOT USED ANYMORE
copyDb() {
  Firestore.instance.collection('products').snapshots().listen(
    (products) {
      products.documents.forEach((productFound) async {
        var category;
        switch (productFound['category']) {
          case 'catFood':
            {
              category = 1;
            }
            break;
          case 'dogFood':
            {
              category = 2;
            }
            break;
          case 'shampoo':
            {
              category = 3;
            }
            break;
          case 'grooming':
            {
              category = 4;
            }
            break;
          case 'bird':
            {
              category = 5;
            }
            break;
          case 'bones':
            {
              category = 6;
            }
            break;
          case 'bowl':
            {
              category = 7;
            }
            break;
          case 'pro':
            {
              category = 8;
            }
            break;
          case 'misc':
            {
              category = 9;
            }
            break;
          case 'toys':
            {
              category = 10;
            }
            break;
          case 'vitamines':
            {
              category = 11;
            }
            break;
          default:
            {
              print('Product not found so it defaulted to 1');
              category = 1;
            }
        }
        Response response;
        try {
          response = await dio.post("http://10.0.2.2:5000/api/product", data: {
            "categoryId": category,
            "name": productFound['name'],
            "img": productFound['img'],
            "originalPrice": double.parse(productFound['price'][0]),
            "sellingPrice": double.parse(productFound['price'][1]),
            "sku": productFound['sku'],
            "description": productFound['desc'],
          });
          print(response);
        } catch (e) {
          print(e);
        }
      });
    },
  );
} // A list of Maps with Product info
