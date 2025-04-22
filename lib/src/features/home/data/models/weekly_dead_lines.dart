import 'dart:convert';

class WeeklyDeadLines {
  int? studentId;
  int? instructorId;
  int? courseId;
  Course? course;

  WeeklyDeadLines({
    this.studentId,
    this.instructorId,
    this.courseId,
    this.course,
  });

  factory WeeklyDeadLines.fromRawJson(String str) =>
      WeeklyDeadLines.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeeklyDeadLines.fromJson(Map<String, dynamic> json) =>
      WeeklyDeadLines(
        studentId: json["student_id"],
        instructorId: json["instructor_id"],
        courseId: json["course_id"],
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "instructor_id": instructorId,
        "course_id": courseId,
        "course": course?.toJson(),
      };
}

class Course {
  int? courseId;
  List<Assignment>? assignment;
  String? courseName;

  Course({
    this.courseId,
    this.assignment,
    this.courseName,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseId: json["course_id"],
        assignment: json["assignment"] == null
            ? []
            : List<Assignment>.from(
                json["assignment"]!.map((x) => Assignment.fromJson(x))),
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "assignment": assignment == null
            ? []
            : List<dynamic>.from(assignment!.map((x) => x.toJson())),
        "course_name": courseName,
      };
}

class Assignment {
  int? assignId;
  int? courseId;
  String? assignTitle;
  int? instructorId;
  DateTime? assignDuedate;
  String? assignDescription;

  Assignment({
    this.assignId,
    this.courseId,
    this.assignTitle,
    this.instructorId,
    this.assignDuedate,
    this.assignDescription,
  });

  factory Assignment.fromRawJson(String str) =>
      Assignment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        assignId: json["assign_id"],
        courseId: json["course_id"],
        assignTitle: json["assign_title"],
        instructorId: json["instructor_id"],
        assignDuedate: json["assign_duedate"] == null
            ? null
            : DateTime.parse(json["assign_duedate"]),
        assignDescription: json["assign_description"],
      );

  Map<String, dynamic> toJson() => {
        "assign_id": assignId,
        "course_id": courseId,
        "assign_title": assignTitle,
        "instructor_id": instructorId,
        "assign_duedate": assignDuedate?.toIso8601String(),
        "assign_description": assignDescription,
      };
}
