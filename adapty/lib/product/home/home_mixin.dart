part of 'home_view.dart';

mixin _HomeMixin on State<HomeView> {
  late final PaymentService _paymentService;
  late final Profile _profile;

  void _plus() async {
    final result = await _paymentService.applePay(
      items: [
        PaymentItem(
          amount: '30',
          label: '30\$ per month',
          status: PaymentItemStatus.final_price,
          type: PaymentItemType.item,
        ),
      ],
    );
    if (result.isEmpty) return;
    debugPrint('$result');
    _saveSubToken('6f98327f-9688-42c5-8d9f-8c4891250e5d');
  }

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

  void _addNote() async {
    final note = await NewNoteDialog.show(context);
    if (note != null) {
      setState(() {
        _mainList.add(note);
      });
    }
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
