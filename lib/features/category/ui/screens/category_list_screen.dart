import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/widgets/category_item_widgets.dart';
import 'package:ecommerce/features/common/widgets/simmer_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static const String name = '/category-list-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category List'),
          leading: IconButton(
            onPressed: () => _onPop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
            builder: (controller) {
              if (controller.inProgress) {
                return SimmerAnimationWidget();
              }
              return GridView.builder(
                itemCount: controller.categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(child: CategoriesItemWidget(categoryModel: controller.categoryList[index],));
                },
              );
            }
          ),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
