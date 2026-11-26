import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dummy_students_data.dart';
import '../../data/models/student_model.dart';
import 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(const StudentsState());

  Future<void> load() async {
    if (isClosed) return;

    emit(state.copyWith(status: StudentsStatus.loading, clearError: true));

    final Either<AppErrorModel, List<StudentModel>> result =
        await DummyStudentsData.load();

    if (isClosed) return;

    result.fold(
      (AppErrorModel error) => emit(
        state.copyWith(
          status: StudentsStatus.failure,
          errorMessage: error.message,
          isRefreshing: false,
        ),
      ),
      (List<StudentModel> students) => emit(
        StudentsState(
          status: students.isEmpty
              ? StudentsStatus.empty
              : StudentsStatus.success,
          students: students,
          availableGrades: DummyGradesData.activeGrades,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    if (isClosed || state.status == StudentsStatus.loading) return;

    emit(
      state.copyWith(
        status: StudentsStatus.loading,
        isRefreshing: true,
        clearError: true,
      ),
    );

    final Either<AppErrorModel, List<StudentModel>> result =
        await DummyStudentsData.load();

    Future.delayed(const Duration(seconds: 1), () {
      if (isClosed) return;

      result.fold(
        (AppErrorModel error) => emit(
          state.copyWith(
            status: state.students.isEmpty
                ? StudentsStatus.failure
                : StudentsStatus.success,
            errorMessage: error.message,
            isRefreshing: false,
          ),
        ),
        (List<StudentModel> students) => emit(
          state.copyWith(
            status: students.isEmpty
                ? StudentsStatus.empty
                : StudentsStatus.success,
            students: students,
            availableGrades: DummyGradesData.activeGrades,
            visibleCount: StudentsState.pageSize,
            isRefreshing: false,
            clearError: true,
          ),
        ),
      );
    });
  }

  void updateQuery(String query) {
    emit(
      state.copyWith(
        query: query,
        visibleCount: StudentsState.pageSize,
        clearError: true,
      ),
    );
  }

  void clearSearch() => updateQuery('');

  void loadMore() {
    emit(
      state.copyWith(visibleCount: state.visibleCount + StudentsState.pageSize),
    );
  }

  void selectGrade(GradeModel? grade) {
    emit(
      state.copyWith(
        gradeFilter: grade,
        clearGradeFilter: grade == null,
        visibleCount: StudentsState.pageSize,
      ),
    );
  }
}
