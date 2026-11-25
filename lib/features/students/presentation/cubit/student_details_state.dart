import 'package:equatable/equatable.dart';

import '../../data/models/student_model.dart';

enum StudentDetailsStatus { loading, success, failure }

class StudentDetailsState extends Equatable {
  const StudentDetailsState({
    this.status = StudentDetailsStatus.loading,
    this.student,
    this.errorMessage,
  });

  final StudentDetailsStatus status;
  final StudentModel? student;
  final String? errorMessage;

  StudentDetailsState copyWith({
    StudentDetailsStatus? status,
    StudentModel? student,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StudentDetailsState(
      status: status ?? this.status,
      student: student ?? this.student,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, student, errorMessage];
}
