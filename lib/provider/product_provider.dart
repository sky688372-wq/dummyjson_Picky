import 'dart:convert';

import 'package:dummyjson/model_class/product.dart';
import 'package:dummyjson/model_class/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  String? _selectedCategory; // null이면 "전체"
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  String? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 전체 상품 로드
  Future<void> loadProducts() async {
    _isLoading = true;
    _selectedCategory = null;
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

  // 카테고리 목록 로드 (칩에 표시할 목록)
  Future<void> loadCategories() async {
    final url = Uri.parse('https://dummyjson.com/products/categories');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _categories = data.map((e) => Category.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('카테고리 로드 실패: $e');
    }
  }

  // 특정 카테고리로 필터링
  Future<void> loadProductsByCategory(String slug) async {
    _isLoading = true;
    _selectedCategory = slug;
    notifyListeners();

    final url = Uri.parse('https://dummyjson.com/products/category/$slug');

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

  //상품 검색 함수
  Future<void> searchProduct(String searchText) async {
    _isLoading = true;
    notifyListeners(); //이거 안해서 오류 계속 찾았다.....
    final url = Uri.parse('https://dummyjson.com/products/search?q=$searchText');

    try {
      final response = await http.get(url);

      if(response.statusCode == 200) {
        final productResponse = ProductResponse.fromJson(jsonDecode(response.body));
        _products = productResponse.products;
        _errorMessage = null;

      } else {
        _errorMessage = '상품을 불러오지 못했습니다. (${response.statusCode})';
      }
    } catch(e) {
      _errorMessage = '통신 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}