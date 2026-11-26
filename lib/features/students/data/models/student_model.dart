import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';

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
    required this.gradeId,
    this.isActive = true,
    this.isLoginLinked = true,
    this.courses = const <StudentCourseModel>[],
    this.results = const <StudentExamResultModel>[],
  });

  final String id;
  final String name;
  final String email;

  /// Grade id shared with the grades feature (see `DummyGradesData`).
  final String gradeId;
  final bool isActive;
  final bool isLoginLinked;
  final List<StudentCourseModel> courses;
  final List<StudentExamResultModel> results;

  String get gradeLabel => DummyGradesData.nameOf(gradeId);

  String get statusLabel => isActive ? 'نشط' : 'موقوف';

  StudentModel copyWith({
    String? name,
    String? email,
    String? gradeId,
    bool? isActive,
    bool? isLoginLinked,
    List<StudentCourseModel>? courses,
    List<StudentExamResultModel>? results,
  }) {
    return StudentModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      gradeId: gradeId ?? this.gradeId,
      isActive: isActive ?? this.isActive,
      isLoginLinked: isLoginLinked ?? this.isLoginLinked,
      courses: courses ?? this.courses,
      results: results ?? this.results,
    );
  }
}
