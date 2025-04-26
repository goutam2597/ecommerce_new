import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:flutter/material.dart';


import '../widgets/app_logo_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }
  Future<void> _moveToNextScreen() async{
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      Navigator.pushReplacementNamed(context, EmailVerificationScreen.name);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Spacer(),
            AppLogoWidget(logoHeight: 200,),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
