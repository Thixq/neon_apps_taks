part of '../sign_up_view.dart';

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: AppSizes.medium,
        children: [
          CustomFormField(
            hintText: 'Nick name',
            validator: Validator.generic.isEmpty,
          ),
          CustomFormField(
            hintText: 'Full name',
            validator: Validator.generic.isEmpty,
          ),
          CustomFormField(
            hintText: 'Email',
            validator: Validator.sign.emailValidator,
          ),

          CustomFormField(
            hintText: 'Password',
            obscureText: true,
            validator: Validator.sign.passwordValidator,
          ),
        ],
      ),
    );
  }
}
