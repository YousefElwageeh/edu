import 'dart:convert';

class TodaySchedule {
  int? courseId;
  CourseTodaySchedule? course;

  TodaySchedule({
    this.courseId,
    this.course,
  });

  factory TodaySchedule.fromRawJson(String str) =>
      TodaySchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodaySchedule.fromJson(Map<String, dynamic> json) => TodaySchedule(
        courseId: json["course_id"],
        course: json["course"] == null
            ? null
            : CourseTodaySchedule.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "course": course?.toJson(),
      };
}

class CourseTodaySchedule {
  List<Session>? session;
  String? courseName;

  CourseTodaySchedule({
    this.session,
    this.courseName,
  });

  factory CourseTodaySchedule.fromRawJson(String str) =>
      CourseTodaySchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseTodaySchedule.fromJson(Map<String, dynamic> json) =>
      CourseTodaySchedule(
        session: json["session"] == null
            ? []
            : List<Session>.from(
                json["session"]!.map((x) => Session.fromJson(x))),
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "session": session == null
            ? []
            : List<dynamic>.from(session!.map((x) => x.toJson())),
        "course_name": courseName,
      };
}

class Session {
  int? courseId;
  DateTime? sessionTime;
  String? sessionType;

  Session({
    this.courseId,
    this.sessionTime,
    this.sessionType,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        courseId: json["course_id"],
        sessionTime: json["session_time"] == null
            ? null
            : DateTime.parse(json["session_time"]),
        sessionType: json["session_type"],
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "session_time": sessionTime?.toIso8601String(),
        "session_type": sessionType,
      };
}
