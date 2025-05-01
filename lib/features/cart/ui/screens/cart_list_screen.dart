import 'package:ecommerce/features/product/ui/controllers/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_colors.dart';

import '../../../common/ui/controllers/main_bottom_nav_controller.dart';
import '../widgets/cart_product_item_widget.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
            onPressed: () => _onPop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CartListController>(
          builder: (controller) {
            if (controller.inProgress) {
              {
                return Center(child: CircularProgressIndicator());
              }
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartListModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CartProductItemWidget(
                        cartData: controller.cartListModel.data![index],
                      );
                    },
                  ),
                ),
                _buildPriceAndCheckoutSection(textTheme),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }

  Widget _buildPriceAndCheckoutSection(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.themeColor.withAlpha(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Total Price', style: textTheme.titleSmall),
              Text(
                '\$100',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(onPressed: () {}, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }
}
