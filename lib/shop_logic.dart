import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:realpet/components/snackbar.dart';

var logger = Logger();

/// HTTP connection settings.
BaseOptions dioOptions = BaseOptions(
    baseUrl: 'http://10.0.2.2:5000',
    receiveDataWhenStatusError: true,
    connectTimeout: 6 * 1000, // 6 seconds
    receiveTimeout: 6 * 1000 // 6 seconds
    );
Dio dio = Dio(dioOptions);

/// Returns all products.
Future getProducts() async {
  Response response;
  try {
    response = await dio.get('/api/product');
    logger.i(response.statusCode);
  } on DioError catch (e) {
    logger.e(e.type);
    return e.type;
  }
  return response.data;
}

/// Returns products from a specific __[categoryId]__.
Future getCategoryProducts(categoryId) async {
  Response response;
  try {
    response = await dio.get('/api/product/category/$categoryId');
    logger.i(response.statusCode);
  } on DioError catch (e) {
    logger.e(e.type);
    return e.type;
  }
  return response.data;
}

/// Advanced search,
/// searches products based on criteria:
/// * __[term]__ : Text to search.
/// * __[page]__ : The page of the results.
/// * __[category]__ : Category name.
/// * __[lowestPrice]__ : Lowest price of the product.
/// * __[highestPrice]__ : Highest price of the product.
Future searchProducts({term, page, category, lowestPrice, highestPrice}) async {
  Response response;
  var formData = FormData.fromMap({
    'page': page,
    'category': category,
    'lowestPrice': lowestPrice,
    'highestPrice': highestPrice,
    'searchTerm': term,
  });
  try {
    response = await dio.post('/api/product/search', data: formData);
    logger.i(response.statusCode);
  } on DioError catch (e) {
    logger.e(e.type);
    return e.type;
  }
  return response.data;
}

/// Adds a new product.
/// * @required __[categoryId]__ : The id of the category to add the product.
/// * @required __[name]__ : Name of the product.
/// * @required __[img]__ : The image source.
/// * @required __[originalPrice]__ : The starting price.
/// * @required __[sellingPrice]__ : The final selling price.
/// * @required __[description]__ : Detailed product description.
/// * @required __[sku]__ : Product stock keeping unit.
Future<Object> addProduct({
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
    response = await dio.post('/api/product', data: {
      'categoryId': categoryId,
      'name': name,
      'img': img,
      'originalPrice': originalPrice,
      'sellingPrice': sellingPrice,
      'sku': sku,
      'description': description,
    });
    logger.v(response);
  } on DioError catch (e) {
    logger.e(e.type);
    return e.type;
  }
  return response;
}

/// Checks for server __[response]__ codes.
/// *  __[DioErrorType.CONNECT_TIMEOUT]__
/// *  __[DioErrorType.RECEIVE_TIMEOUT]__
/// *  __[DioErrorType.RESPONSE]__
/// *  __[DioErrorType.CANCEL]__
/// *  __[DioErrorType.DEFAUL]__
bool checkResponse(response) {
  if (response == DioErrorType.CONNECT_TIMEOUT) {
    logger.e('Received ERROR $response');
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: 'Η σύνδεση με τον διακομιστή απέτυχε',
      title: 'Σφάλμα',
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.RECEIVE_TIMEOUT) {
    logger.e('Received ERROR $response');
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: 'Η απάντηση του διακομιστή απέτυχε',
      title: 'Σφάλμα',
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.RESPONSE) {
    logger.e('Received ERROR $response');
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: 'Λανθασμένη απάντηση του διακομιστή',
      title: 'Σφάλμα',
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.CANCEL) {
    logger.e('Received ERROR $response');
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: 'Η κλήση προς τον διακομιστή ακυρώθηκε',
      title: 'Σφάλμα',
      duration: 3,
    );
    return false;
  } else if (response == DioErrorType.DEFAULT) {
    logger.e('Received ERROR $response');
    snackBar(
      iconData: FontAwesomeIcons.times,
      iconColor: Colors.redAccent,
      text: 'Άγνωστο σφάλμα διακομιστή',
      title: 'Σφάλμα',
      duration: 3,
    );
    return false;
  }
  return true;
}
