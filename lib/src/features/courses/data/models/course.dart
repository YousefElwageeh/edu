import 'dart:convert';

class Subjects {
  int? studentId;
  Course? course;
  Instructor? instructor;

  Subjects({
    this.studentId,
    this.course,
    this.instructor,
  });

  factory Subjects.fromRawJson(String str) =>
      Subjects.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        studentId: json["student_id"],
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        instructor: json["instructor"] == null
            ? null
            : Instructor.fromJson(json["instructor"]),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "course": course?.toJson(),
        "instructor": instructor?.toJson(),
      };
}

class Course {
  int? courseId;
  String? courseName;
  String? courseDescription;

  Course({
    this.courseId,
    this.courseName,
    this.courseDescription,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseId: json["course_id"],
        courseName: json["course_name"],
        courseDescription: json["course_description"],
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "course_name": courseName,
        "course_description": courseDescription,
      };
}

class Instructor {
  int? instructorId;
  String? instructorName;

  Instructor({
    this.instructorId,
    this.instructorName,
  });

  factory Instructor.fromRawJson(String str) =>
      Instructor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        instructorId: json["instructor_id"],
        instructorName: json["instructor_name"],
      );

  Map<String, dynamic> toJson() => {
        "instructor_id": instructorId,
        "instructor_name": instructorName,
      };
}
