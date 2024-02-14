import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/box_constants.dart';
import '../../../../utils/constants/textstyles.dart';
import '../../../../utils/global_widgets/baseScaffold.dart';
import '../../../../utils/global_widgets/primary_button.dart';
import '../../../../utils/global_widgets/textfield.dart';
import '../../login/screens/login.dart';
import '../provider/signup_provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Consumer<SignupProvider>(builder: (_, provider, __) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Register Yourself!', style: TT.f28w600),
              Box.box24h,
              CustomTextField(
                controller: _emailController,
                labelText: 'Email Id',
                inputType: TextInputType.emailAddress,
                validator: (v) => provider.verifyEmail(v ?? ""),
              ),
              Box.box16h,
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                validator: (v) => provider.verifyPassword(v ?? ""),
              ),
              Box.box16h,
              CustomTextField(
                controller: _confirmController,
                labelText: 'Confirm Password',
                validator: (v) {
                  if (v != _passwordController.text) {
                    return 'Passwords aren\'t Matching';
                  }
                  return null;
                },
              ),
              Box.box24h,
              PrimaryButton(
                  label: 'Register',
                  isLoading: provider.isLoading,
                  onTap: () {
                    try {
                      if (_passwordController.text != _confirmController.text) {
                        throw ('Passwords need to match');
                      }
                      provider.signup(_emailController.text,
                          _passwordController.text, context);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }),
              Box.box24h,
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
              Box.box24h,
              const Text(
                "Already Have An Account?",
                style: TT.f16w400,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('Login'))
            ],
          ),
        );
      }),
    );
  }
}
