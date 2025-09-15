import 'package:clone_insta/feature/utils/firebase/firestore_query.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Firebase Firestore service
final class FirebaseFirestoreService {
  /// Constructor
  FirebaseFirestoreService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Filter _createCombinedFilter(List<Filter>? filters) {
    if (filters == null || filters.isEmpty) {
      throw ArgumentError('Filtre listesi boş olamaz.');
    }

    if (filters.length == 1) {
      return filters.first;
    }

    // İlk iki filtreyi birleştirerek başla
    var combined = Filter.and(filters[0], filters[1]);

    // Kalan filtreleri sırayla ekle
    for (var i = 2; i < filters.length; i++) {
      combined = Filter.and(combined, filters[i]);
    }

    return combined;
  }

  /// get Firestore collection with optional query
  Future<QuerySnapshot> getCollection(
    String collectionPath, {
    FirestoreQuery? query,
  }) async {
    Query<Map<String, dynamic>> firestoreQuery = _firestore.collection(
      collectionPath,
    );

    if (query != null) {
      if (query.filters != null && query.filters!.isNotEmpty) {
        firestoreQuery = firestoreQuery.where(
          _createCombinedFilter(query.filters),
        );
      }

      if (query.sorts != null && query.sorts!.isNotEmpty) {
        for (final sort in query.sorts!) {
          firestoreQuery = firestoreQuery.orderBy(
            sort.field,
            descending: sort.descending,
          );
        }
      }

      if (query.limit != null && query.limit! > 0) {
        firestoreQuery = firestoreQuery.limit(query.limit!);
      }
    }

    return firestoreQuery.get();
  }
}
