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
          TextFormField(
            decoration: const InputDecoration(hintText: 'Nick Name'),
            validator: Validator.generic.isEmpty,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Full Name'),
            validator: Validator.generic.isEmpty,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Email'),
            validator: Validator.sign.emailValidator,
          ),

          TextFormField(
            decoration: const InputDecoration(hintText: 'Password'),
            validator: Validator.sign.passwordValidator,
          ),
        ],
      ),
    );
  }
}
