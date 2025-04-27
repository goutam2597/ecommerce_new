
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/common/data/models/product_model.dart';
import 'package:ecommerce/features/product/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.productModel,});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsScreen.name,arguments: 1);
      },
      child: SizedBox(
        width: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),

                child: Image.network(productModel.image??'',
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: 8,
                  right: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      productModel.title??'',
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${productModel.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Text(
                              '${productModel.star}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
