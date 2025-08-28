import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubscriptionLocalSyncService {
  SubscriptionLocalSyncService._({
    required FlutterSecureStorage storageInstance,
  }) : _localStorage = storageInstance;
  static SubscriptionLocalSyncService? _instance;
  static SubscriptionLocalSyncService instance(
    FlutterSecureStorage storageInstance,
  ) {
    return _instance ??= SubscriptionLocalSyncService._(
      storageInstance: storageInstance,
    );
  }

  final FlutterSecureStorage _localStorage;

  Future<bool> saveToken(String token) async {
    try {
      await _localStorage.write(key: 'SubscriptionToken', value: token);
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> subscriptionSync() async {
    try {
      final value = await _localStorage.read(key: 'SubscriptionToken');
      if (value == null || value.isEmpty) {
        return false;
      }
      // backend verification and other network checks ...
      print(value);
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
