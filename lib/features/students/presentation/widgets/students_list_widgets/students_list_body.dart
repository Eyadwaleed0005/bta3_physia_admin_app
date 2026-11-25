import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_empty_grade_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_empty_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_failure_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_loading_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_no_results_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_success_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsListBody extends StatelessWidget {
  const StudentsListBody({
    super.key,
    required this.state,
    required this.onOpenStudent,
  });

  final StudentsState state;
  final ValueChanged<String> onOpenStudent;

  @override
  Widget build(BuildContext context) {
    final StudentsCubit cubit = context.read<StudentsCubit>();

    switch (state.status) {
      case StudentsStatus.loading:
        return const StudentsLoadingState();

      case StudentsStatus.failure:
        return StudentsFailureState(
          message:
              state.errorMessage ?? 'تأكد من الاتصال بالإنترنت وأعد المحاولة.',
          onRetry: cubit.load,
        );

      case StudentsStatus.empty:
        return const StudentsEmptyState();

      case StudentsStatus.success:
        if (state.filteredStudents.isEmpty) {
          return state.hasSearch
              ? const StudentsNoResultsState()
              : const StudentsEmptyGradeState();
        }

        return StudentsSuccessState(
          state: state,
          onOpenStudent: onOpenStudent,
          onLoadMore: cubit.loadMore,
          onClearSearch: cubit.clearSearch,
        );
    }
  }
}
