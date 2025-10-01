import 'package:equatable/equatable.dart';

/// This abstract class is the base class for all models in this project.
abstract class BaseModel<T> implements Equatable {
  /// The constructor for the model.
  const BaseModel({required this.id});

  /// The id of the model.
  final String id;

  /// You must implement this method to convert a JSON map to an object of type [T].
  T fromJson(Map<String, dynamic> json);

  /// You must implement this method to convert an object of type [T] to a JSON map.
  Map<String, dynamic> toJson();
}
