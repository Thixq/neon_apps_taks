part of 'sign_up_view.dart';

mixin _SignUpMixin on State<SignUpView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _nickNameController;
  late final ProfileManager _profileManager;

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final result = await _profileManager.signUpWithEmailAndPassword(
        nickName: _nickNameController.text,
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (result) {
        if (mounted) await context.router.replaceAll([const HomeShellRoute()]);
      }
    }
  }

  void _signInGo() {
    context.router.replace(const SignInRoute());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _nickNameController = TextEditingController();
    _profileManager = DependencyContainer.profileManager;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }
}
