part of '../sign_in_view.dart';

class _SignInForm extends StatelessWidget {
  const _SignInForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: AppSizes.medium,
        children: [
          CustomFormField(
            hintText: 'Email',
            validator: (text) => Validator.sign.emailValidator(text),
            controller: emailController,
          ),

          CustomFormField(
            hintText: 'Password',
            obscureText: true,
            validator: (text) => Validator.sign.passwordValidator(text),
            controller: passwordController,
          ),
        ],
      ),
    );
  }
}
