part of 'sign_in_view.dart';

mixin _SignInMixin on State<SignInView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final ProfileManager _profileManager;

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      final result = await _profileManager.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (result) {
        if (mounted) await context.router.replaceAll([const HomeShellRoute()]);
      }
    }
  }

  void _signUpGo() {
    context.router.replace(const SignUpRoute());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _profileManager = DependencyContainer.manager.profileManager;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
