import 'dart:convert';

class Projects {
  int? activityId;
  String? activityTitle;
  String? activityDescription;
  DateTime? activityDuedate;
  int? instructorId;
  bool isFinished = false;

  Projects({
    this.activityId,
    this.activityTitle,
    this.activityDescription,
    this.activityDuedate,
    this.instructorId,
    this.isFinished = false,
  });

  factory Projects.fromRawJson(String str) =>
      Projects.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        activityId: json["activity_id"],
        activityTitle: json["activity_title"],
        activityDescription: json["activity_description"],
        activityDuedate: json["activity_duedate"] == null
            ? null
            : DateTime.parse(json["activity_duedate"]),
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "activity_title": activityTitle,
        "activity_description": activityDescription,
        "activity_duedate": activityDuedate?.toIso8601String(),
        "instructor_id": instructorId,
      };
}
