import 'package:flutter/cupertino.dart';
import 'package:foodify/screens/details/detail_controller.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colours.dart';
import '../../model/product_model.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;
    final controller = Get.put(ProductDetailController());
    return CupertinoPageScaffold(
      backgroundColor: AppColours.bG,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColours.kPrimaryPurple,
        border: null,

        // White back button
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          child: const Icon(
            CupertinoIcons.back,
            color: CupertinoColors.white,
            size: 24,
          ),
        ),

        middle: const Text(
          "Product Detail",
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    product.images,
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (_, _, _) => Container(
                      height: 280,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColours.kPrimaryPurple,
                            AppColours.kLightPurple
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.photo,
                          color: CupertinoColors.white,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.white,
                    decoration: TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 6),

                // Category
                Text(
                  product.category.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    decoration: TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 14),

                // Price
                Text(
                  "₹${product.price.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                    decoration: TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 18),

                // Description
                Text(
                  product.description ,
                  style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.white,
                    height: 1.45,
                    decoration: TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 28),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      controller.addToCartAndGoToCartTab();
                    },
                    child: const Text("Add to Cart",style: TextStyle(
                      color: CupertinoColors.black,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
