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
    // 1. Ensure controller is registered to avoid crashes
    final DashboardController controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());

    return Container(
      color: AppColours.bG,
      child: CupertinoPageScaffold(
        backgroundColor: AppColours.bG,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColours.kPrimaryPurple,
          border: null, // Removed border for seamless look
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
            child: const Icon(CupertinoIcons.square_arrow_right,
                color: CupertinoColors.white),
            onPressed: () {
              controller.logout();
            },
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            // ---------------------------------------------
            // ✅ FIXED: LOADER VISIBILITY
            // ---------------------------------------------
            if (controller.productsLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(
                      radius: 16,
                      color: CupertinoColors.white, // Changed to WHITE so it shows on purple bg
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Loading Products...",
                      style: TextStyle(
                        color: CupertinoColors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (controller.productsError.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_triangle_fill,
                      size: 64,
                      color: CupertinoColors.white, // Changed to white for visibility
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        controller.productsError.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white,
                          height: 1.4,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CupertinoButton.filled(
                      onPressed: controller.fetchAllProducts,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(), // iOS bounce effect
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                    children: controller.productsList
                        .map((product) => _ProductCard(product: product))
                        .toList(),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          }),
        ),
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
        preventDuplicates: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColours.kPrimaryPurple.withValues(alpha: 0.15),
              CupertinoColors.systemBackground,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppColours.kPrimaryPurple.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColours.kPrimaryPurple.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  product.images,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColours.kPrimaryPurple,
                        AppColours.kLightPurple,
                      ]),
                    ),
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
                mainAxisSize: MainAxisSize.min, // Hug content
                children: [
                  // Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                      color: CupertinoColors.black,
                      decoration: TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Category
                  Text(
                    product.category.name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.secondaryLabel,
                      decoration: TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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