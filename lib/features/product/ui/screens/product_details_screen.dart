import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_service.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/common/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/widgets/product_item_widget.dart';
import 'package:ecommerce/features/common/widgets/simmer_animation_widget.dart';
import 'package:ecommerce/features/product/data/models/product_details_model.dart';
import 'package:ecommerce/features/product/ui/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/features/product/ui/controllers/product_details_controller.dart';
import 'package:ecommerce/features/product/ui/widgets/color_picker_widget.dart';
import 'package:ecommerce/features/product/ui/widgets/product_image_carousel_slider.dart';
import 'package:ecommerce/features/common/widgets/product_qty_inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/ui/controller/popular_product_list_controller.dart';
import '../widgets/size_picker_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productID});
  static const String name = '/product/product-details';

  final int productID;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productID);
    });
  }

  void _handleColorSelected(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _handleSizeSelected(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _handleQtyChanged(int qty) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined, size: 28),
            ),
          )
        ],
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (controller) {
          if (controller.inProgress) {
            return CenteredCircularProgressIndicator();
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          ProductDetails productDetails = controller.productDetails!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarouselSlider(
                        imageUrls: [
                          productDetails.img1!,
                          productDetails.img2!,
                          productDetails.img3!,
                          productDetails.img4!,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productDetails.product?.title ?? '',
                                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 18),
                                          Text(
                                            '${productDetails.product?.star ?? ''}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text('Reviews'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: AppColors.themeColor,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: Icon(Icons.favorite_border, size: 16, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ProductQtyIncDecButton(
                                  onChanged: _handleQtyChanged,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Color', style: textTheme.titleMedium),
                            const SizedBox(height: 8),
                            ColorPickerWidget(
                              colors: productDetails.color?.split(',') ?? [],
                              onColorSelected: _handleColorSelected,
                            ),
                            const SizedBox(height: 16),
                            Text('Size', style: textTheme.titleMedium),
                            const SizedBox(height: 8),
                            SizePickerWidget(
                              sizes: productDetails.size?.split(',') ?? [],
                              onSizeSelected: _handleSizeSelected,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Product Description',
                              style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              productDetails.des ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Popular Products', style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            GetBuilder<PopularProductListController>(
                              builder: (controller) {
                                if (controller.inProgress) {
                                  return SimmerAnimationWidget();
                                }
                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.popularProductList.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder: (context, index) {
                                    return FittedBox(
                                      child: ProductItemWidget(
                                        productModel: controller.popularProductList[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPriceAndAddToCartSection(textTheme, productDetails.product?.price ?? '0.0'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(TextTheme textTheme, String price) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.themeColor.withAlpha(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: textTheme.titleSmall),
              Text(
                '\$$price',
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
            child: GetBuilder<AddToCartController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return CenteredCircularProgressIndicator();
                }
                return ElevatedButton(
                    onPressed: () async {
                      if (_selectedColor == null || _selectedSize == null) {
                        Get.snackbar('Error', 'Please select color and size');
                        return;
                      }

                      bool loggedIn = await AuthService.isLoggedIn();

                      if (!loggedIn) {
                        Get.toNamed(EmailVerificationScreen.name);
                        return;
                      }

                      final isSuccess = await controller.addToCart(
                        widget.productID,
                        _selectedColor!,
                        _selectedSize!,
                      );

                      if (isSuccess) {
                        Get.snackbar('Success', 'Added to cart');
                      } else {
                        Get.snackbar('Error', controller.errorMessage ?? 'Something went wrong');
                      }
                    },
                    child: Text('Add to cart'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
