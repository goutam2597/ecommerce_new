import 'package:ecommerce/features/product/data/models/cart_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../common/widgets/product_qty_inc_dec_button.dart';

class CartProductItemWidget extends StatelessWidget {
  final CartData cartData;

  const CartProductItemWidget({super.key, required this.cartData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Image.network(
              cartData.product?.image ?? '',
              height: 90,
              width: 90,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartData.product?.title ?? '',
                              maxLines: 1,
                              style: textTheme.bodyLarge?.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Text('Color:${cartData.color ?? ''}'),
                                SizedBox(width: 8),
                                Text('Size:${cartData.size}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartData.product?.price ?? ''}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      ProductQtyIncDecButton(onChanged: (int noOfItem) {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
