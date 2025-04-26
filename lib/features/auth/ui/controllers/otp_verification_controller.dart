import 'package:ecommerce/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

import '../../../../app/urls.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool _shouldNavigateCompleteProfile = false;
  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  Future<bool> verifyOtp(String email,String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.verifyOtpUrl(email,otp),
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      String token= response.responseData['data'];
      await Get.find<ReadProfileController>().readProfileData(token);
      if(Get.find<ReadProfileController>().profileModel==null){
        // TODO: complete profile
        _shouldNavigateCompleteProfile =true;
      }else{
        _shouldNavigateCompleteProfile = false;
        // TODO: save user data & access token
      }
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
