import 'package:dummyjson/model_class/product.dart';
import 'package:dummyjson/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Image.asset('assets/app_logo/app_logo.png', fit: BoxFit.cover),
      ),

      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final List<Product> cartProducts = cartProvider.cartProducts;

            // 장바구니가 비어있을 때
            if (cartProducts.isEmpty) {
              return const Center(
                child: Text(
                  "장바구니가 비어있습니다.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListView.separated(
                itemCount: cartProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  final discountedPrice =
                      product.price * (1 - product.discountPercentage / 100);
                  final isLowStock = product.availabilityStatus == "Low Stock";

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. 상품 썸네일
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.thumbnail,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // 2. 상품 정보
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 브랜드 + 카테고리
                              Row(
                                children: [
                                  if (product.brand != null) ...[
                                    Text(
                                      product.brand!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "·",
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                  Text(
                                    product.category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              // 상품명
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // 평점
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 14, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text(
                                    product.rating.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  // 재고 배지
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isLowStock
                                          ? Colors.orange.withValues(alpha: 0.15)
                                          : Colors.green.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      isLowStock ? "재고 부족" : "재고 있음",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isLowStock
                                            ? Colors.orange
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              // 가격 + 할인율
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${discountedPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (product.discountPercentage > 0) ...[
                                    const SizedBox(width: 6),
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${product.discountPercentage.toStringAsFixed(0)}%",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 3. 삭제 버튼
                        IconButton(
                          onPressed: () {
                            context.read<CartProvider>().removeFromCart(
                              context,
                              product,
                            );
                          },
                          icon: const Icon(Icons.highlight_remove, size: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}