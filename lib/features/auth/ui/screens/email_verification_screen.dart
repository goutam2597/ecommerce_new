import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});
  static const String name = '/email-verification';
  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                AppLogoWidget(logoHeight: 200),
                Text('Welcome Back', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'Please enter your email address',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'name@example.com'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return 'Enter your email address';
                    }
                    if(EmailValidator.validate(value!)==false){
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // if(_formKey.currentState!.validate()){
                    // }return;
                    Navigator.pushNamed(context, OtpVerificationScreen.name);
                  },
                  child: Text('NEXT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
