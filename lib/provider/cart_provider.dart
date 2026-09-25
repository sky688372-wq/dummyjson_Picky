import 'package:dummyjson/model_class/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartProducts = []; // 장바구니 상태 관리 리스트

  // 카트에 추가하는 매서드
  void addToCart(Product product) {
    cartProducts.add(product);
    notifyListeners();
  }

  // 카트에서 해당 상품을 삭제하는 매서드
  void removeFromCart(Product product) {
    cartProducts.remove(product);
    notifyListeners();
  }
}