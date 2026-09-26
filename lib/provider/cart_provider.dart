import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/model_class/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartProducts = []; // 장바구니 상태 관리 리스트

  // 카트에 추가하는 매서드
  void addToCart(BuildContext context, Product product) {
    if(cartProducts.contains(product)) { //만일 카트에 이미 동일 상품이 존해한다면 종료
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primary,
            behavior: SnackBarBehavior.floating,
            content: Text(
              "해당 상품은 이미 장바구니에 담겨져 있습니다.",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
      );
      return;
    }

    //동일 상품이 없다면 추가하고 알림
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
            "장바구니에서 삭제되었습니다.",
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
    );
  }
}
