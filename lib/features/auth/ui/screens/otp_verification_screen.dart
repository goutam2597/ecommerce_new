import 'dart:async';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_constants.dart';
import 'package:ecommerce/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:ecommerce/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:ecommerce/features/common/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  static const String name = '/otp-verification';
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxInt _remainingTime = AppConstants.resendOTPTimer.obs;
  late Timer timer;
  final RxBool _enableResendCodeButton = false.obs;
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();

  @override
  void initState() {
    super.initState();
    _startResendCodeTimer();
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remainingTime.value = AppConstants.resendOTPTimer;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _remainingTime.value--;
      if (_remainingTime.value == 0) {
        t.cancel();
        _enableResendCodeButton.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                AppLogoWidget(logoHeight: 200),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'A 6 digit otp has been sent to your email',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  validator: (String? value) {
                    if (value?.length != 6) {
                      return 'Enter the otp';
                    }
                    return null;
                  },
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(microseconds: 300),
                  appContext: context,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldWidth: 50,
                    fieldHeight: 50,
                    activeFillColor: AppColors.themeColor,
                    activeColor: AppColors.themeColor,
                    inactiveColor: AppColors.themeColor,
                    selectedColor: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 24),
                GetBuilder<OtpVerificationController>(
                  builder: (controller) {
                    if(controller.inProgress){
                      return CenteredCircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: _onTapNextButton,
                      child: Text('NEXT'),
                    );
                  }
                ),
                const SizedBox(height: 24),
                Obx(
                  () => Visibility(
                    visible: !_enableResendCodeButton.value,
                    child: RichText(
                      text: TextSpan(
                        text: 'This code will be expired in ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '$_remainingTime',
                            style: const TextStyle(color: AppColors.themeColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _enableResendCodeButton.value,
                    child: TextButton(
                      onPressed: () {
                        _startResendCodeTimer();
                      },
                      child: Text('Resend Code'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    {
      if (_formKey.currentState!.validate()) {
        final bool response = await _otpVerificationController.verifyOtp(
          widget.email,
          _otpController.text,
        );
        if (response) {
          if (mounted) {
            Navigator.pushNamed(context, CompleteProfileScreen.name);
          }
        } else {
          if (mounted) {
            showSnackBarMessage(
              context,
              _otpVerificationController.errorMessage!,
            );
          }
        }
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
