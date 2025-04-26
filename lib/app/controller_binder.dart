import 'package:ecommerce/features/common/data/models/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/home/ui/controller/home_banner_list_controller.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../features/auth/ui/controllers/email_verification_controller.dart';
import '../features/auth/ui/controllers/otp_verification_controller.dart';
import '../features/auth/ui/controllers/read_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(HomeBannerListController());
    Get.put(CategoryListController());
  }

}

