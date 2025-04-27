import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/common/data/models/category_model.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CategoriesItemWidget extends StatelessWidget {
  const CategoriesItemWidget({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: {
            'categoryName': categoryModel.categoryName!,
            'categoryId': categoryModel.id!,
          },
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.themeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16),
            child: Image.network(
              categoryModel.categoryImg ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categoryModel.categoryName ?? '',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.themeColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
