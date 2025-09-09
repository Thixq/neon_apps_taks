import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/components/custom_form_field.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/extensions/num_extension.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:clone_insta/feature/utils/validators/validator.dart';
import 'package:flutter/material.dart';

part 'sign_up_mixin.dart';
part 'widgets/sign_up_form.dart';

const String _signInTitle = 'Neon Apps Social';
const String _signUpButton = 'Sign up';
const String _signInGoView = 'Already have an account?';

/// Sign up view
@RoutePage()
class SignUpView extends StatefulWidget {
  /// Sign up view
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with _SignUpMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  spacing: AppSizes.extraLarge * 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitle(context),
                    _buildForm(),
                    _buildSignUpButton(context),
                  ],
                ),
              ),
              _buildSignInGo(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buildSignInGo() =>
      TextButton(onPressed: _signInGo, child: const Text(_signInGoView));

  SizedBox _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: 100.w(context),
      child: FilledButton(
        onPressed: _signUp,
        child: const Text(_signUpButton),
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      _signInTitle,
      style: context.textTheme.headlineMedium,
    );
  }

  _SignUpForm _buildForm() {
    return _SignUpForm(
      formKey: _formKey,
    );
  }
}
