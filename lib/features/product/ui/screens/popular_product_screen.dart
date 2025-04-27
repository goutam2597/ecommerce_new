import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/widgets/product_item_widget.dart';
import 'package:ecommerce/features/common/widgets/simmer_animation_widget.dart';
import 'package:ecommerce/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  static const String name = '/popular-product-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Popular Product'),
          leading: IconButton(
            onPressed: () => _onPop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search,size: 32,),
            ),
          ),],
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            Get.find<PopularProductListController>().getPopularProductList();
          },
          child: GetBuilder<PopularProductListController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return SimmerAnimationWidget();
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: controller.popularProductList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(child: ProductItemWidget(productModel: controller.popularProductList[index],));
                    },
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  void _onPop() {
    Get.back();
    Get.find<MainBottomNavController>().backToHome();
  }
}
