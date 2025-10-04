import 'dart:convert';

class Quizes {
  int? quizId;
  String? quizDuration;
  DateTime? quizDueDateTime;
  int? instructorId;
  int? courseId;
  List<QuizQuestion>? questions;
  String? quizTitle;
  List<dynamic>? student;
  bool isFinished;
  String? score;

  Course? course;

  Quizes({
    this.quizId,
    this.quizDuration,
    this.quizDueDateTime,
    this.instructorId,
    this.courseId,
    this.questions,
    this.quizTitle,
    this.student,
    this.isFinished = false,
    this.score,
    this.course,
  });

  factory Quizes.fromRawJson(String str) => Quizes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quizes.fromJson(Map<String, dynamic> json) => Quizes(
        quizId: json["quiz_id"],
        quizDuration: json["quiz_duration"],
        quizDueDateTime: json["quiz_dueDateTime"] == null
            ? null
            : DateTime.parse(json["quiz_dueDateTime"]),
        instructorId: json["instructor_id"],
        courseId: json["course_id"],
        questions: json["quiz_questions"] == null
            ? []
            : List<QuizQuestion>.from(
                json["quiz_questions"]!.map((x) => QuizQuestion.fromJson(x))),
        quizTitle: json["quiz_title"],
        student: json["student"] == null
            ? []
            : List<dynamic>.from(json["student"]!.map((x) => x)),
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "quiz_duration": quizDuration,
        "quiz_dueDateTime": quizDueDateTime?.toIso8601String(),
        "instructor_id": instructorId,
        "course_id": courseId,
        "quiz_questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "quiz_title": quizTitle,
        "student":
            student == null ? [] : List<dynamic>.from(student!.map((x) => x)),
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

class QuizQuestion {
  int? marks;
  List<String>? options;
  String? question;
  String? correctAnswer;

  QuizQuestion({
    this.marks,
    this.options,
    this.question,
    this.correctAnswer,
  });

  factory QuizQuestion.fromRawJson(String str) =>
      QuizQuestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        marks: json["marks"],
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
