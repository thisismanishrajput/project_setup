import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api/api.dart';
import 'package:untitled1/helper/SharedPreferences.dart';
import 'package:untitled1/model/product_model.dart';


abstract class ProductProvider extends ChangeNotifier {
  List<Product> get productList;
  bool get isProductLoading;
  Future<void> fetchProducts(BuildContext context);

}

class ProductImpl extends ChangeNotifier implements ProductProvider {
  final Dio _dio = Dio();

  bool _isProductLoading = false;

  @override
  bool get isProductLoading => _isProductLoading;

  List<Product> _productList = [];

  @override
  List<Product> get productList => _productList;

  addProductToList({required List<Product> list}) {
    _productList.addAll(list);
      _isProductLoading = false;
    notifyListeners();
  }

  @override
  Future<void> fetchProducts(BuildContext context) async {
    try {
      _isProductLoading = true;
        var response = await _dio.get(
          API.products,
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ),
        );
        if (response.statusCode == 200) {
          addProductToList( list: ProductModel.fromJson(response.data).products);
          notifyListeners();
        }

    } on DioException catch (e) {
      rethrow;
    } finally {
      if (_isProductLoading  ) {
        _isProductLoading = false;
        notifyListeners();
      }

    }
  }
}
