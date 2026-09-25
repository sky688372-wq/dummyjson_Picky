import 'dart:convert';

import 'package:dummyjson/model_class/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://dummyjson.com/products?limit=0');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final productResponse = ProductResponse.fromJson(jsonDecode(response.body));
        _products = productResponse.products;
        _errorMessage = null;
      } else {
        _errorMessage = '상품을 불러오지 못했습니다. (${response.statusCode})';
      }
    } catch (e) {
      _errorMessage = '통신 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}