class StudentModel {
  final int studentId;
  final String studentName;
  final String studentPassword;
  final int studentLevel;
  final String studentMajor;
  final double studentCgpa;
  final int institutionId;

  StudentModel({
    required this.studentId,
    required this.studentName,
    required this.studentPassword,
    required this.studentLevel,
    required this.studentMajor,
    required this.studentCgpa,
    required this.institutionId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['student_id'],
      studentName: json['student_name'],
      studentPassword: json['student_password'],
      studentLevel: json['student_level'],
      studentMajor: json['student_major'],
      studentCgpa: json['student_cgpa'].toDouble(),
      institutionId: json['institution_id'],
    );
  }
}
