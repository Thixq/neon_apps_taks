part of 'home_view.dart';

mixin _HomeMixin on State<HomeView> {
  late final PaymentService _paymentService;
  late final Profile _profile;

  final List<NoteModel> _mockList = List.generate(
    12,
    (index) => NoteModel(
      id: '$index',
      title: '#$index title',
      content: 'Lorem Ipsum' * index,
      time: DateTime.now().add(Duration(minutes: index)),
    ),
  );

  late List<NoteModel> _mainList;

  void _addNote(NoteModel note) {
    setState(() {
      _mainList.add(note);
    });
  }

  Future<void> _paymentInit() async {
    final appleConfig = await PaymentConfiguration.fromAsset(
      PaymentAsset.appleConfig,
    );
    _paymentService = PaymentService(Pay({PayProvider.apple_pay: appleConfig}));
  }

  void _saveSubToken(String token) async {
    final subLocal = SubscriptionLocalSyncService.instance(
      FlutterSecureStorage(),
    );
    await subLocal.saveToken(token);
    setState(() {
      _profile.updateSubscriptionInfo(
        TempSubInfo(
          isActiveSubscription: true,
          subscriptionStatus: SubscriptionBundle.plus,
        ),
      );
    });
  }

  @override
  void initState() {
    _paymentInit();
    _mainList = [..._mockList];
    _profile = Profile.instance;
    super.initState();
  }
}
