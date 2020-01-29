/// Represents a model type stored in the API database.
abstract class ApiModel {
  /// The ID of the instance.
  int id;

  /// The date the instance was created.
  DateTime createdAt;

  /// The date the instance was last updated.
  DateTime updatedAt;

  Map<String, dynamic> toJson();
}
