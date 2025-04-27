import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:ecommerce/features/category/ui/screens/category_list_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav.dart';
import 'package:ecommerce/features/product/ui/screens/popular_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/product/ui/screens/product_details_screen.dart';
import '../features/product/ui/screens/product_list_screen.dart';

class BdBay extends StatelessWidget {
  const BdBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemeData.lightThemeData,
      initialRoute: '/',
      initialBinding: ControllerBinder(),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == EmailVerificationScreen.name) {
          widget = const EmailVerificationScreen();
        } else if (settings.name == OtpVerificationScreen.name) {
          String email = settings.arguments as String;
          widget = OtpVerificationScreen(email: email);
        } else if (settings.name == CompleteProfileScreen.name) {
          widget = const CompleteProfileScreen();
        } else if (settings.name == MainBottomNav.name) {
          widget = const MainBottomNav();
        } else if (settings.name == CategoryListScreen.name) {
          widget = const CategoryListScreen();
        } else if (settings.name == ProductListScreen.name) {
          Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          widget = ProductListScreen(
            categoryName: args['categoryName'],
            categoryId: args['categoryId'],
          );
        } else if (settings.name == ProductDetailsScreen.name) {
          int productId = settings.arguments as int;
          widget = ProductDetailsScreen(productID: productId);
        } else if (settings.name == PopularProductScreen.name) {
          widget = const PopularProductScreen();
        }
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}
