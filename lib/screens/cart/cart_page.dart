import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colours.dart';
import '../dashboard /dashboard_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboard = Get.find<DashboardController>();

    return CupertinoPageScaffold(
      backgroundColor: AppColours.bG,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColours.kPrimaryPurple,
        border: null,
        middle: const Text(
          "My Cart",
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 25
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.square_arrow_right, color: CupertinoColors.white),
          onPressed: () {
           dashboard.logout();
          },
        ),
      ),

      child: SafeArea(
        child: Obx(() {


          if (dashboard.cartItems.isEmpty) {
            return const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  color: CupertinoColors.white,
                  decoration: TextDecoration.none,
                  fontSize: 16,
                ),
              ),
            );
          }

          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dashboard.cartItems.length,
                  itemBuilder: (context, index) {

                    final item = dashboard.cartItems[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item.image,
                                height: 54,
                                width: 54,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// TITLE + PRICE
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: CupertinoColors.black,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "₹${item.price.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: AppColours.kPrimaryPurple,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 6),

                            /// QUANTITY STEPPER
                            Row(
                              children: [

                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      item.quantity--;
                                    } else {
                                      dashboard.cartItems.removeAt(index);
                                    }
                                    dashboard.cartItems.refresh();
                                  },
                                  child: const Icon(
                                    CupertinoIcons.minus_circle_fill,
                                    size: 22,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    "${item.quantity}",
                                    style: const TextStyle(
                                      color: CupertinoColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    item.quantity++;
                                    dashboard.cartItems.refresh();
                                  },
                                  child: Icon(
                                    CupertinoIcons.plus_circle_fill,
                                    size: 22,
                                    color: AppColours.kPrimaryPurple,
                                  ),
                                ),
                              ],
                            ),

                            /// DELETE BUTTON
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => dashboard.cartItems.removeAt(index),
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: CupertinoColors.destructiveRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),


              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.black.withValues(alpha: 0.15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// TOTAL AMOUNT
                    Obx(() => Text(
                      "Total: ₹${dashboard.totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    )),

                    CupertinoButton.filled(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(14),
                      onPressed: () {
                        dashboard.checkout();
                      },
                      child: const Text("Checkout",style: TextStyle(color: CupertinoColors.black),),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
