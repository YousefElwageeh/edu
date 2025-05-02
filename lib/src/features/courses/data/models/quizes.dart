import 'dart:convert';

class Quizes {
  int? quizId;
  double? quizFullmark;
  String? quizDuration;
  String? quizFilepath;
  DateTime? quizDuedatetime;
  int? instructorId;
  int? courseId;
  List<Question>? questions;
  List<Student>? student;
  Course? course;
  bool isFinished = false;

  Quizes({
    this.quizId,
    this.quizFullmark,
    this.quizDuration,
    this.quizFilepath,
    this.quizDuedatetime,
    this.instructorId,
    this.courseId,
    this.questions,
    this.isFinished = false,
    this.student,
    this.course,
  });

  factory Quizes.fromRawJson(String str) => Quizes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quizes.fromJson(Map<String, dynamic> json) => Quizes(
        quizId: json["quiz_id"],
        quizFullmark: json["quiz_fullmark"],
        quizDuration: json["quiz_duration"],
        quizFilepath: json["quiz_filepath"],
        quizDuedatetime: json["quiz_duedatetime"] == null
            ? null
            : DateTime.parse(json["quiz_duedatetime"]),
        instructorId: json["instructor_id"],
        courseId: json["course_id"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        student: json["student"] == null
            ? []
            : List<Student>.from(
                json["student"]!.map((x) => Student.fromJson(x))),
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "quiz_fullmark": quizFullmark,
        "quiz_duration": quizDuration,
        "quiz_filepath": quizFilepath,
        "quiz_duedatetime": quizDuedatetime?.toIso8601String(),
        "instructor_id": instructorId,
        "course_id": courseId,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "student": student == null
            ? []
            : List<dynamic>.from(student!.map((x) => x.toJson())),
        "course": course?.toJson(),
      };
}

class Course {
  String? courseName;

  Course({
    this.courseName,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
      };
}

class Question {
  String? marks;
  List<String>? options;
  String? question;
  String? correctAnswer;

  Question({
    this.marks,
    this.options,
    this.question,
    this.correctAnswer,
  });

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        marks: json["marks"].toString(),
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        question: json["question"],
        correctAnswer: json["correct_answer"],
      );

  Map<String, dynamic> toJson() => {
        "marks": marks,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "question": question,
        "correct_answer": correctAnswer,
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
