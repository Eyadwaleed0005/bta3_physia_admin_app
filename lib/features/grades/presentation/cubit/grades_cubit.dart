import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dummy_grades_data.dart';
import '../../data/models/grade_model.dart';
import 'grades_state.dart';

class GradesCubit extends Cubit<GradesState> {
  GradesCubit() : super(const GradesState());

  int _requestId = 0;
  bool _isFetching = false;

  Future<void> load() async {
    if (isClosed || _isFetching) return;

    await _fetch(showFullLoading: true);
  }

  Future<void> refresh() async {
    if (isClosed || _isFetching) return;

    await _fetch(showFullLoading: false);
  }

  void addGrade(String name) {
    if (isClosed) return;

    DummyGradesData.addGrade(name);
    _emitStore();
  }

  void renameGrade(String gradeId, String name) {
    if (isClosed) return;

    DummyGradesData.renameGrade(gradeId, name);
    _emitStore();
  }

  void setGradeActive(String gradeId, bool isActive) {
    if (isClosed) return;

    DummyGradesData.setGradeActive(gradeId, isActive);
    _emitStore();
  }

  bool isNameTaken(String name, {String? excludeId}) {
    return DummyGradesData.isNameTaken(name, excludeId: excludeId);
  }

  Future<void> _fetch({required bool showFullLoading}) async {
    _isFetching = true;
    final int requestId = ++_requestId;

    if (showFullLoading) {
      emit(state.copyWith(status: GradesStatus.loading, clearError: true));
    } else {
      emit(state.copyWith(isRefreshing: true, clearError: true));
    }

    final Either<AppErrorModel, List<GradeModel>> result =
        await DummyGradesData.load();

    if (isClosed || requestId != _requestId) {
      _isFetching = false;
      return;
    }

    result.fold(
      (AppErrorModel error) => emit(
        state.copyWith(
          status: state.hasGrades ? GradesStatus.success : GradesStatus.failure,
          isRefreshing: false,
          errorMessage: error.message,
        ),
      ),
      (List<GradeModel> grades) => emit(
        GradesState(
          status: grades.isEmpty ? GradesStatus.empty : GradesStatus.success,
          grades: grades,
        ),
      ),
    );

    _isFetching = false;
  }

  void _emitStore() {
    if (isClosed) return;

    final List<GradeModel> grades = DummyGradesData.grades;

    emit(
      state.copyWith(
        status: grades.isEmpty ? GradesStatus.empty : GradesStatus.success,
        grades: grades,
        isRefreshing: false,
        clearError: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _requestId++;
    return super.close();
  }
}
