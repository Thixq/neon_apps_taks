import 'package:cloud_firestore/cloud_firestore.dart';

/// A class that holds the criteria for a Firestore query.
class FirestoreQuery {
  FirestoreQuery({
    this.filters,
    this.sorts,
    this.limit,
  });

  /// The filters to be applied (e.g. whereEqualTo, whereGreaterThan).
  final List<Filter>? filters;

  /// The sort orders to be applied (e.g. orderBy).
  final List<Sort>? sorts;

  /// The maximum number of documents to be retrieved.
  final int? limit;
}

/// A class representing a filter condition for Firestore queries.
final class Sort {
  /// Creates a [Sort] instance.
  const Sort({required this.field, this.descending = false});

  /// The field to sort by.
  final String field;

  /// Whether the sorting should be in descending order.
  final bool descending;
}
