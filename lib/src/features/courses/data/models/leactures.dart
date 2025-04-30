import 'dart:convert';

class Leactures {
  Course? course;
  Student? student;

  Leactures({
    this.course,
    this.student,
  });

  factory Leactures.fromRawJson(String str) =>
      Leactures.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leactures.fromJson(Map<String, dynamic> json) => Leactures(
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "course": course?.toJson(),
        "student": student?.toJson(),
      };
}

class Course {
  List<Session>? session;
  int? courseId;
  List<Instructor>? instructor;
  String? courseName;

  Course({
    this.session,
    this.courseId,
    this.instructor,
    this.courseName,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        session: json["session"] == null
            ? []
            : List<Session>.from(
                json["session"]!.map((x) => Session.fromJson(x))),
        courseId: json["course_id"],
        instructor: json["instructor"] == null
            ? []
            : List<Instructor>.from(
                json["instructor"]!.map((x) => Instructor.fromJson(x))),
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "session": session == null
            ? []
            : List<dynamic>.from(session!.map((x) => x.toJson())),
        "course_id": courseId,
        "instructor": instructor == null
            ? []
            : List<dynamic>.from(instructor!.map((x) => x.toJson())),
        "course_name": courseName,
      };
}

class Instructor {
  String? instructorName;

  Instructor({
    this.instructorName,
  });

  factory Instructor.fromRawJson(String str) =>
      Instructor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        instructorName: json["instructor_name"],
      );

  Map<String, dynamic> toJson() => {
        "instructor_name": instructorName,
      };
}

class Session {
  int? sessionId;
  String? sessionType;
  String? sessionFilePath;

  Session({
    this.sessionId,
    this.sessionType,
    this.sessionFilePath,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json["session_id"],
        sessionType: json["session_type"],
        sessionFilePath: json["session_file_path"],
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "session_type": sessionType,
        "session_file_path": sessionFilePath,
      };
}

class Student {
  int? studentId;
  String? studentName;

  Student({
    this.studentId,
    this.studentName,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["student_id"],
        studentName: json["student_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "student_name": studentName,
      };
}
