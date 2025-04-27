import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/data/models/category_model.dart';
import 'package:ecommerce/features/common/data/models/product_model.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/home/ui/controller/home_banner_list_controller.dart';
import 'package:ecommerce/features/home/ui/controller/new_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/controller/special_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/widgets/app_bar_icon_button.dart';
import 'package:ecommerce/features/common/widgets/category_item_widgets.dart';
import 'package:ecommerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:ecommerce/features/home/ui/widgets/home_section_header.dart';
import 'package:ecommerce/features/home/ui/widgets/product_search_bar.dart';
import 'package:ecommerce/features/product/ui/screens/popular_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/app_colors.dart';
import '../../../common/widgets/product_item_widget.dart';
import '../../../common/widgets/simmer_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(controller: _searchBarController),
              const SizedBox(height: 16),
              GetBuilder<HomeBannerListController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      height: 180,
                      child: SimmerAnimationWidget(),
                    );
                  }
                  return HomeCarouselSlider(bannerList: controller.bannerList);
                },
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(
                onTap: () {
                  Get.find<MainBottomNavController>().moveToCategory();
                },
                title: 'Categories',
              ),
              const SizedBox(height: 8),
              GetBuilder<CategoryListController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      height: 100,
                      child: Shimmer.fromColors(
                        baseColor: AppColors.themeColor.withAlpha(40),
                        highlightColor: AppColors.themeColor.withAlpha(20),
                        child: Container(
                          color: AppColors.themeColor.withAlpha(50),
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getCategoriesList(controller.categoryList),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(
                onTap: () {
                  Navigator.pushNamed(context, PopularProductScreen.name);
                },
                title: 'Popular',
              ),
              const SizedBox(height: 8),
              GetBuilder<PopularProductListController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      height: 200,
                      child: SimmerAnimationWidget(),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductsList(controller.popularProductList),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(onTap: () {}, title: 'Special'),
              const SizedBox(height: 8),
              GetBuilder<SpecialProductListController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      height: 200,
                      child: SimmerAnimationWidget(),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductsList(controller.specialProductList),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(onTap: () {}, title: 'New'),
              const SizedBox(height: 8),
              GetBuilder<NewProductListController>(
                builder: (controller) {
                  if (controller.inProgress) {
                    return SizedBox(
                      height: 200,
                      child: SimmerAnimationWidget(),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductsList(controller.newProductList),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCategoriesList(List<CategoryModel> categoryListModels) {
    List<Widget> categoriesList = [];
    for (int i = 0; i < categoryListModels.length; i++) {
      categoriesList.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CategoriesItemWidget(categoryModel: categoryListModels[i]),
        ),
      );
    }
    return categoriesList;
  }

  List<Widget> _getProductsList(List<ProductModel> productList) {
    List<Widget> list = [];
    for (int i = 0; i < productList.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ProductItemWidget(productModel: productList[i]),
        ),
      );
    }
    return list;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Image.asset(AssetsPath.longLogoPng, width: 100),
      actions: [
        AppBarIconButton(icon: Icons.person_2_outlined, onTap: () {}),
        const SizedBox(width: 8),
        AppBarIconButton(icon: Icons.wifi_calling_3_outlined, onTap: () {}),
        const SizedBox(width: 8),
        AppBarIconButton(
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
