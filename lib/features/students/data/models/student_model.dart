import 'package:bta3_physia_admin/core/helper/grade_name_helper.dart';

enum StudentGrade {
  firstSecondary,
  secondSecondary,
  thirdSecondary;

  String get id => switch (this) {
    StudentGrade.firstSecondary => 'secondary_1',
    StudentGrade.secondSecondary => 'secondary_2',
    StudentGrade.thirdSecondary => 'secondary_3',
  };

  String get label => GradeNameHelper.getGradeName(id);
}

class StudentCourseModel {
  const StudentCourseModel({
    required this.id,
    required this.title,
    this.isActivated = false,
    this.activationLabel,
  });

  final String id;
  final String title;
  final bool isActivated;
  final String? activationLabel;

  StudentCourseModel copyWith({bool? isActivated, String? activationLabel}) {
    return StudentCourseModel(
      id: id,
      title: title,
      isActivated: isActivated ?? this.isActivated,
      activationLabel: activationLabel ?? this.activationLabel,
    );
  }
}

class StudentExamResultModel {
  const StudentExamResultModel({
    required this.title,
    required this.scoreLabel,
    this.dateLabel,
  });

  final String title;
  final String scoreLabel;
  final String? dateLabel;
}

class StudentModel {
  const StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.grade,
    this.isActive = true,
    this.isLoginLinked = true,
    this.courses = const <StudentCourseModel>[],
    this.results = const <StudentExamResultModel>[],
  });

  final String id;
  final String name;
  final String email;
  final StudentGrade grade;
  final bool isActive;
  final bool isLoginLinked;
  final List<StudentCourseModel> courses;
  final List<StudentExamResultModel> results;

  String get statusLabel => isActive ? 'نشط' : 'موقوف';

  StudentModel copyWith({
    String? name,
    String? email,
    StudentGrade? grade,
    bool? isActive,
    bool? isLoginLinked,
    List<StudentCourseModel>? courses,
    List<StudentExamResultModel>? results,
  }) {
    return StudentModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      grade: grade ?? this.grade,
      isActive: isActive ?? this.isActive,
      isLoginLinked: isLoginLinked ?? this.isLoginLinked,
      courses: courses ?? this.courses,
      results: results ?? this.results,
    );
  }
}
