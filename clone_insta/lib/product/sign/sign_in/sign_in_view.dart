import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/components/custom_form_field.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/extensions/num_extension.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:clone_insta/feature/utils/validators/validator.dart';
import 'package:flutter/material.dart';

part 'sign_in_mixin.dart';
part 'widgets/sign_in_form.dart';

const String _signInTitle = 'Neon Apps Social';

const String _signInButton = 'Sign in';

const String _signUpButton = "Don't you have an account?";

/// Sign in view

@RoutePage()
class SignInView extends StatefulWidget {
  /// Sign in view
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with _SignInMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  spacing: AppSizes.extraLarge * 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitle(context),
                    _buildFormField(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    _buildSignInButton(context),
                  ],
                ),
              ),
              _buildSignUpGo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpGo() {
    return TextButton(
      onPressed: _signUpGo,
      child: const Text(_signUpButton),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: 100.w(context),
      child: FilledButton(
        onPressed: _signIn,
        child: const Text(_signInButton),
      ),
    );
  }

  Widget _buildFormField({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    return _SignInForm(
      formKey: formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      _signInTitle,
      style: context.textTheme.headlineMedium,
    );
  }
}
