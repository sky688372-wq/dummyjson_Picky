import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/model_class/product.dart';
import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  List<Product> wishListProducts = [];

  // 위시 리스트에 추가 매서드
  void addToWishList(BuildContext context ,Product product) {
    if(wishListProducts.contains(product)) { //만일 해당 제품이 이미 위시 리스트에 존재한다면
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primary,
            behavior: SnackBarBehavior.floating,
            content: Text(
              "해당 상품은 이미 위시리스트에 담겨져 있습니다.",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
      );
      return;
    } else { //위시 리스트에 없다면
      wishListProducts.add(product);

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
  }

  //위시리스트 탭에서만 삭제할 수 있도록 할거임
  //위시리스트 삭제 매서드
  void removeFromWishList(BuildContext context ,Product product) {
    wishListProducts.remove(product);
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
}