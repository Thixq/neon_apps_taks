import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/user_preview_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// User query operations (user query, search, etc.)
final class UsersManager {
  /// Constructor
  UsersManager({required FirebaseFirestore firestore}) : _firestore = firestore;
  final FirebaseFirestore _firestore;

  /// Get users (with pagination)
  Future<List<UserPreviewModel>> getUsers({
    required int pageSize,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = _firestore
        .collection(EndPointConstant.users)
        .orderBy(
          EndPointConstant.createdAt,
        )
        .limit(pageSize);
    if (startAfter != null) query = query.startAfterDocument(startAfter);
    final snapshot = await query
        .withConverter(
          fromFirestore: (snapshot, _) =>
              UserPreviewModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
}
