import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

// METHOD FOR RETRIEVING ALL PRODUCTS
getProducts() async {
  Response response;
  try {
    response = await dio.get("http://10.0.2.2:5000/api/product");
    print(response.statusCode);
    print(response.data.length);
  } catch (e) {
    print(e);
  }
  return response.data;
}

// METHOD FOR RETRIEVING ALL PRODUCTS ON A SPECIFIC CATEGORY
getCategoryProducts(categoryId) async {
  Response response;
  try {
    response =
        await dio.get("http://10.0.2.2:5000/api/product/category/$categoryId");
    print(response.statusCode);
    print(response.data.length);
  } catch (e) {
    print(e);
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
    response = await dio.post("http://10.0.2.2:5000/api/product", data: {
      "categoryId": categoryId,
      "name": name,
      "img": img,
      "originalPrice": originalPrice,
      "sellingPrice": sellingPrice,
      "sku": sku,
      "description": description,
    });
    print(response);
  } catch (e) {
    print(e);
  }
  return response;
}

// A METHOD FOR COPYING MY FIREBASE TO postgresql
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
