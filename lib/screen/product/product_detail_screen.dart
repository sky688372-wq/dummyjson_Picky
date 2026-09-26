import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/app_function/app_function.dart';
import 'package:dummyjson/model_class/product.dart';
import 'package:dummyjson/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // 할인가 계산
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Scaffold(
      // 0. 뒤로가기용 앱바
      appBar: AppBar(
        actions: [
          //공유 아이콘 버튼
          IconButton(
            onPressed: () {
              AppFunction.showBuilding(context);
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            // 1. 상단 상품 이미지
            //API보니까 리스트라고 하지만 동일 이미지 하나씩 밖에 없어서 그냥 thumbnail 그대로 씀
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Image.network(product.thumbnail, fit: BoxFit.cover),
            ),

            const SizedBox(height: 10),

            // 2. 브랜드명 Text
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  AppFunction.showBuilding(context);
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.brand ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(width: 4),

                    Icon(Icons.arrow_forward_ios, size: 15),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 6),

            // 3. 제품 이름 텍스트
            Text(
              product.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // 4. 평점 + 리뷰 개수
            Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                Text(
                  "(${product.reviews.length}개 리뷰)",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 5. 가격 + 할인율
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${discountedPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(width: 8),
                if (product.discountPercentage > 0) ...[
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${product.discountPercentage.toStringAsFixed(0)}% 할인",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),

            // 6. 재고 상태 배지
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: product.availabilityStatus == "Low Stock"
                    ? Colors.orange.withValues(alpha: 0.15)
                    : Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${product.availabilityStatus} · 재고 ${product.stock}개",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: product.availabilityStatus == "Low Stock"
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Divider(),

            const SizedBox(height: 8),

            // 7. 상세 설명
            const Text(
              "상품 설명",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              product.description,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 16),

            const Divider(),

            const SizedBox(height: 8),

            // 8. 배송/반품 정보
            const Text(
              "배송 및 반품 정보",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_shipping_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(product.shippingInformation)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.assignment_return_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(product.returnPolicy)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.verified_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(product.warrantyInformation)),
              ],
            ),

            const SizedBox(height: 16),

            const Divider(),

            const SizedBox(height: 8),

            // 9. 리뷰 목록
            Text(
              "리뷰 (${product.reviews.length})",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...product.reviews.map(
              (review) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.reviewerName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 14,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(review.comment),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80), // 하단 고정 버튼 공간 확보
          ],
        ),
      ),

      // 10. 하단 고정 버튼 (장바구니 담기 / 찜하기)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // todo 찜하기 로직 (WishlistProvider)
                  AppFunction.showBuilding(context);
                },
                icon: Icon(Icons.favorite_border),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColor.primary,
                  ),
                  onPressed: () {
                    context.read<CartProvider>().addToCart(context, widget.product);
                  },
                  child: Text(
                    "장바구니에 담기",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
