import 'package:dummyjson/provider/product_provider.dart';
import 'package:dummyjson/screen/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 검색어 컨트롤러
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 화면 진입 시 바로 상품/카테고리 조회
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
      context.read<ProductProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 0. 앱바
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Image.asset('assets/app_logo/app_logo.png', fit: BoxFit.cover),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 1. 검색 텍스트 필드
              TextField(
                controller: _searchCtrl,
                onSubmitted: (value) {
                  context.read<ProductProvider>().searchProduct(_searchCtrl.text);
                },
                decoration: InputDecoration(
                  hintText: "어떤 상품을 찾고 계신가요?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // 통신 정상 확인함
                      context.read<ProductProvider>().searchProduct(_searchCtrl.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.15),
                ),
              ),

              const SizedBox(height: 12),

              // 2. 카테고리 칩 목록
              Consumer<ProductProvider>( //컨슈머로 바로바로 바뀌자마자 리빌드 가능하도록
                builder: (context, productProvider, child) {
                  if (productProvider.categories.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: productProvider.categories.length + 1,
                      // "전체" 포함
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        // 첫 번째는 "전체" 칩
                        if (index == 0) {
                          final isSelected =
                              productProvider.selectedCategory == null;
                          return ChoiceChip(
                            label: const Text('전체'),
                            selected: isSelected,
                            onSelected: (_) {
                              context.read<ProductProvider>().loadProducts();
                            },
                          );
                        }

                        final category = productProvider.categories[index - 1];
                        final isSelected =
                            productProvider.selectedCategory == category.slug;

                        return ChoiceChip(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (_) {
                            context
                                .read<ProductProvider>()
                                .loadProductsByCategory(category.slug);
                          },
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // 3. 상품 목록
              Expanded(
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    if (productProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (productProvider.errorMessage != null) {
                      return Center(child: Text(productProvider.errorMessage!));
                    }

                    if (productProvider.products.isEmpty) {
                      return const Center(child: Text('상품이 없습니다.'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.thumbnail,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
