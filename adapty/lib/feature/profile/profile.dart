// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:adapty/feature/constant/image.dart';

enum SubscriptionBundle { none, standard, plus, ultimate }

final class TempSubInfo {
  final bool isActiveSubscription;
  final SubscriptionBundle subscriptionStatus;

  const TempSubInfo({
    this.isActiveSubscription = false,
    this.subscriptionStatus = SubscriptionBundle.none,
  });

  TempSubInfo copyWith({
    bool? isActiveSubscription,
    SubscriptionBundle? subscriptionStatus,
  }) {
    return TempSubInfo(
      isActiveSubscription: isActiveSubscription ?? this.isActiveSubscription,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
    );
  }
}

final class Profile {
  final String id;
  final String nickName;
  final String fullName;
  final String profileImage;
  final String email;

  TempSubInfo subscriptionInfo;

  static Profile? _instance;

  Profile._internal({
    this.id = '',
    this.nickName = '',
    this.fullName = '',
    this.profileImage = '',
    this.email = '',
    this.subscriptionInfo = const TempSubInfo(),
  });

  static Profile get instance {
    return _instance ??= Profile._internal();
  }

  static Profile createDemoProfile() {
    _instance = Profile._internal(
      id: 'Kaan',
      nickName: 'thixq',
      fullName: 'Kaan EFE',
      profileImage: ImageConst.profile,
      email: 'demo@example.com',
    );
    return _instance ??= Profile._internal();
  }

  Profile copyWith({
    String? id,
    String? nickName,
    String? fullName,
    String? profileImage,
    String? email,
    TempSubInfo? subscriptionInfo,
  }) {
    return Profile._internal(
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
    );
  }

  void updateSubscriptionInfo(TempSubInfo newInfo) {
    subscriptionInfo = newInfo;
  }
}
