part of 'sign_in_view.dart';

mixin _SignInMixin on State<SignInView> {
  late final GlobalKey<FormState> _formKey;

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {}
  }

  void _signUpGo() {
    context.router.replace(const SignUpRoute());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
