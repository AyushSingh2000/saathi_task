import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/box_constants.dart';
import '../../../../utils/constants/textstyles.dart';
import '../../../../utils/global_widgets/baseScaffold.dart';
import '../../../../utils/global_widgets/primary_button.dart';
import '../../../../utils/global_widgets/textfield.dart';
import '../../signup/screens/signup.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Consumer<LoginProvider>(builder: (_, provider, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset('assets/tourist.png', height: 210, width: 210),
              const SizedBox(
                height: 8,
              ),
              const Text('Welcome!', style: TT.f28w600),
              Box.box12h,
              CustomTextField(
                controller: _emailController,
                labelText: 'Email Id',
                inputType: TextInputType.emailAddress,
                validator: (v) => provider.verifyEmail(v ?? ""),
              ),
              Box.box12h,
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                validator: (v) => provider.verifyPassword(v ?? ""),
              ),
              Box.box12h,
              PrimaryButton(
                  label: 'Login',
                  isLoading: provider.isLoading,
                  onTap: () {
                    provider.login(_emailController.text,
                        _passwordController.text, context);
                  }),
              Box.box4h,
              const Text(
                "------Or------",
                style: TT.f16w400,
              ),
              Box.box4h,
              PrimaryButton(
                  label: 'Google Sign-In',
                  isLoading: provider.isLoading,
                  onTap: () {
                    try {
                      provider.googleSignin(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }),
              Box.box12h,
              const Text(
                "Don't Have An Account?",
                style: TT.f16w400,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('Create Account'))
            ],
          ),
        );
      }),
    );
  }
}
