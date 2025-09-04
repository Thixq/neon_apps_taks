part of '../sign_in_view.dart';

class _SignInForm extends StatelessWidget {
  const _SignInForm({
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
          TextFormField(
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (text) => Validator.sign.emailValidator(text),
          ),

          TextFormField(
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (text) => Validator.sign.passwordValidator(text),
          ),
        ],
      ),
    );
  }
}
