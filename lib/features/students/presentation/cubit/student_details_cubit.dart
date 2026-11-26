import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dummy_students_data.dart';
import '../../data/models/student_model.dart';
import 'student_details_state.dart';

class StudentDetailsCubit extends Cubit<StudentDetailsState> {
  StudentDetailsCubit() : super(const StudentDetailsState());

  String? _studentId;

  Future<void> load(String studentId) async {
    if (isClosed) return;

    _studentId = studentId;

    emit(
      state.copyWith(status: StudentDetailsStatus.loading, clearError: true),
    );

    final Either<AppErrorModel, StudentModel> result =
        await DummyStudentsData.loadStudent(studentId);

    if (isClosed) return;

    result.fold(
      (AppErrorModel error) => emit(
        state.copyWith(
          status: StudentDetailsStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (StudentModel student) => emit(
        state.copyWith(
          status: StudentDetailsStatus.success,
          student: student,
          availableGrades: DummyGradesData.activeGrades,
          clearError: true,
        ),
      ),
    );
  }

  Future<void> retry() async {
    final String? studentId = _studentId;

    if (studentId == null) return;

    await load(studentId);
  }

  void changeGrade(String gradeId) {
    final StudentModel? student = state.student;

    if (student == null) return;

    _updateStudent(student.copyWith(gradeId: gradeId));
  }

  void toggleAccountStatus() {
    final StudentModel? student = state.student;

    if (student == null) return;

    _updateStudent(student.copyWith(isActive: !student.isActive));
  }

  void toggleLoginLink() {
    final StudentModel? student = state.student;

    if (student == null) return;

    _updateStudent(student.copyWith(isLoginLinked: !student.isLoginLinked));
  }

  void activateCourse(String courseId, bool activate) {
    final StudentModel? student = state.student;

    if (student == null) return;

    final List<StudentCourseModel> updatedCourses = <StudentCourseModel>[
      for (final StudentCourseModel course in student.courses)
        course.id == courseId
            ? course.copyWith(
                isActivated: activate,
                activationLabel: 'مفعّل حتى نهاية العام',
              )
            : course,
    ];

    _updateStudent(student.copyWith(courses: updatedCourses));
  }

  void deleteStudent() {
    final StudentModel? student = state.student;

    if (student == null) return;

    DummyStudentsData.removeStudent(student.id);
  }

  void _updateStudent(StudentModel updated) {
    DummyStudentsData.updateStudent(updated);

    emit(
      state.copyWith(
        status: StudentDetailsStatus.success,
        student: updated,
        clearError: true,
      ),
    );
  }
}
