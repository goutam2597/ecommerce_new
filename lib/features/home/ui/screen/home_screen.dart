import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/home/ui/widgets/app_bar_icon_button.dart';
import 'package:ecommerce/features/common/widgets/category_item_widgets.dart';
import 'package:ecommerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:ecommerce/features/home/ui/widgets/home_section_header.dart';
import 'package:ecommerce/features/home/ui/widgets/product_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/product_item_widget.dart';

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
              HomeCarouselSlider(),
              const SizedBox(height: 16),
              HomeSectionHeader(
                onTap: () {
                  Get.find<MainBottomNavController>().moveToCategory();
                },
                title: 'Categories',
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _getCategoriesList()),
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(onTap: () {}, title: 'Popular'),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _getProductsList()),
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(onTap: () {}, title: 'Special'),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _getProductsList()),
              ),
              const SizedBox(height: 16),
              HomeSectionHeader(onTap: () {}, title: 'New'),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _getProductsList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCategoriesList() {
    List<Widget> categoriesList = [];
    for (int i = 0; i < 10; i++) {
      categoriesList.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: const CategoriesItemWidget(),
        ),
      );
    }
    return categoriesList;
  }

  List<Widget> _getProductsList() {
    List<Widget> productsList = [];
    for (int i = 0; i < 10; i++) {
      productsList.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: const ProductItemWidget(),
        ),
      );
    }
    return productsList;
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
