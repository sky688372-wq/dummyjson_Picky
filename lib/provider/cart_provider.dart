import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/model_class/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartProducts = []; // 장바구니 상태 관리 리스트

  // 카트에 추가하는 매서드
  void addToCart(BuildContext context, Product product) {
    cartProducts.add(product);
    notifyListeners();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.primary,
        behavior: SnackBarBehavior.floating,
        content: Text(
          "장바구니에 담겼습니다.",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      )
    );
  }

  // 카트에서 해당 상품을 삭제하는 매서드
  void removeFromCart(BuildContext context, Product product) {
    cartProducts.remove(product);
    notifyListeners();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.primary,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "장바구니에 담겼습니다.",
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
    );
  }
}
