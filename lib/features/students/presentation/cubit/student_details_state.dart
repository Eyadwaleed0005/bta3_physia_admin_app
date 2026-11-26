import 'package:equatable/equatable.dart';

import '../../../grades/data/models/grade_model.dart';
import '../../data/models/student_model.dart';

enum StudentDetailsStatus { loading, success, failure }

class StudentDetailsState extends Equatable {
  const StudentDetailsState({
    this.status = StudentDetailsStatus.loading,
    this.student,
    this.availableGrades = const <GradeModel>[],
    this.errorMessage,
  });

  final StudentDetailsStatus status;
  final StudentModel? student;

  final List<GradeModel> availableGrades;
  final String? errorMessage;

  StudentDetailsState copyWith({
    StudentDetailsStatus? status,
    StudentModel? student,
    List<GradeModel>? availableGrades,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StudentDetailsState(
      status: status ?? this.status,
      student: student ?? this.student,
      availableGrades: availableGrades ?? this.availableGrades,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    student,
    availableGrades,
    errorMessage,
  ];
}
