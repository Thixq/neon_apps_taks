part of '../sign_up_view.dart';

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.nickNameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController nickNameController;

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
            controller: nickNameController,
          ),
          CustomFormField(
            hintText: 'Full name',
            validator: Validator.generic.isEmpty,
            controller: nameController,
          ),
          CustomFormField(
            hintText: 'Email',
            validator: Validator.sign.emailValidator,
            controller: emailController,
          ),

          CustomFormField(
            hintText: 'Password',
            obscureText: true,
            validator: Validator.sign.passwordValidator,
            controller: passwordController,
          ),
        ],
      ),
    );
  }
}
