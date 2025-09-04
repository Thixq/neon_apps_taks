part of 'sign_up_view.dart';

mixin _SignUpMixin on State<SignUpView> {
  late final GlobalKey<FormState> _formKey;

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {}
  }

  void _signInGo() {
    context.router.replace(const SignInRoute());
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
