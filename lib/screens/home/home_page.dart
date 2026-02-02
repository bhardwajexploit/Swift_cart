import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colours.dart';
import '../../model/product_model.dart';
import '../dashboard /dashboard_controller.dart';
import '../details/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    return CupertinoPageScaffold(
      backgroundColor: AppColours.bG,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColours.kPrimaryPurple,
        border: null,
        middle: const Text(
          "SwiftCart",
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: controller.logout,
          child: const Icon(
            CupertinoIcons.square_arrow_right,
            color: CupertinoColors.white,
          ),
        ),
      ),
      child: SafeArea(
        child: Obx(() {
          // ---------------- LOADING ----------------
          if (controller.isLoading.value) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 18),
            );
          }

          // ---------------- ERROR ----------------
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    size: 56,
                    color: CupertinoColors.systemRed,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    onPressed: controller.refreshProducts,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // ---------------- EMPTY ----------------
          if (controller.productsList.isEmpty) {
            return const Center(
              child: Text(
                "No products available",
                style: TextStyle(
                  color: CupertinoColors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }

          // ---------------- PRODUCTS ----------------
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    "Products",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                  children: controller.productsList
                      .map((p) => _ProductCard(product: p))
                      .toList(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        }),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
            () => const ProductDetailPage(),
        arguments: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColours.kPrimaryPurple.withValues(alpha: 0.15),
              CupertinoColors.systemBackground,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColours.kPrimaryPurple.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  product.images.isNotEmpty
                      ? product.images.first
                      : product.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: AppColours.kPrimaryPurple,
                    child: const Icon(
                      CupertinoIcons.photo,
                      color: CupertinoColors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.secondaryLabel,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${product.price.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColours.kPrimaryPurple,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
