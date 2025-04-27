import 'package:ecommerce/features/cart/ui/screens/cart_list_screen.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/home/ui/controller/new_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/controller/popular_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/controller/special_product_list_controller.dart';
import 'package:ecommerce/features/home/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../category/ui/screens/category_list_screen.dart';
import '../../../home/ui/controller/home_banner_list_controller.dart';
import '../../../whishlist/ui/screens/wish_list_screen.dart';
import '../controllers/category_list_controller.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});
  static const String name = '/navigation-bar';

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  final HomeBannerListController _homeBannerListController =
  Get.find<HomeBannerListController>();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishlistScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _homeBannerListController.getHomeBannerList();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<PopularProductListController>().getPopularProductList();
    Get.find<SpecialProductListController>().getSpecialProductList();
    Get.find<NewProductListController>().getNewProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (bottomNavController) {
        return Scaffold(
          body: _screens[bottomNavController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: bottomNavController.selectedIndex,
            onDestinationSelected: bottomNavController.changedIndex,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}
