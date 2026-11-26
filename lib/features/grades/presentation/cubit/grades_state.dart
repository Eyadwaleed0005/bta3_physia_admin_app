import 'package:equatable/equatable.dart';

import '../../data/models/grade_model.dart';

enum GradesStatus { loading, success, empty, failure }

class GradesState extends Equatable {
  const GradesState({
    this.status = GradesStatus.loading,
    this.grades = const <GradeModel>[],
    this.isRefreshing = false,
    this.errorMessage,
  });

  final GradesStatus status;
  final List<GradeModel> grades;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasGrades => grades.isNotEmpty;

  GradeModel? gradeById(String gradeId) {
    for (final GradeModel grade in grades) {
      if (grade.id == gradeId) return grade;
    }

    return null;
  }

  GradesState copyWith({
    GradesStatus? status,
    List<GradeModel>? grades,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return GradesState(
      status: status ?? this.status,
      grades: grades ?? this.grades,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    grades,
    isRefreshing,
    errorMessage,
  ];
}
