final String tablePlans = 'plans';

class PlanFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, time
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Plan {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  const Plan({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Plan copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Plan(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Plan fromJson(Map<String, Object?> json) => Plan(
        id: json[PlanFields.id] as int?,
        title: json[PlanFields.title] as String,
        description: json[PlanFields.description] as String,
        createdTime: DateTime.parse(json[PlanFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        PlanFields.id: id,
        PlanFields.title: title,
        PlanFields.description: description,
        PlanFields.time: createdTime.toIso8601String(),
      };
}
