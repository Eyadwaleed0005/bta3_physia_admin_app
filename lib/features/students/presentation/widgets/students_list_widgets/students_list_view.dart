import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_header.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_list_body.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_list_heading.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_search_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsListView extends StatelessWidget {
  const StudentsListView({super.key});

  static const double _bottomContentInset = 128;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsCubit, StudentsState>(
      builder: (BuildContext context, StudentsState state) {
        final StudentsCubit cubit = context.read<StudentsCubit>();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: StudentsHeader(
                title: 'الطلاب',
                subtitle: 'إدارة الطلاب والتفعيلات',
                isRefreshing: state.isRefreshing,
                onRefresh: cubit.refresh,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  8.h,
                  20.w,
                  _bottomContentInset.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.status == StudentsStatus.success ||
                        state.status == StudentsStatus.loading) ...[
                      StudentsListHeading(title: state.listTitle),
                      verticalSpace(14),
                      StudentsSearchRow(
                        initialText: state.query,
                        isFilterActive: state.gradeFilter != null,
                        onQueryChanged: cubit.updateQuery,
                        onFilterTap: () => _openGradeFilter(context, cubit),
                      ),
                      verticalSpace(16),
                    ],
                    StudentsListBody(
                      state: state,
                      onOpenStudent: (String studentId) =>
                          _openStudentDetails(context, cubit, studentId),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openStudentDetails(
    BuildContext context,
    StudentsCubit cubit,
    String studentId,
  ) async {
    await Navigator.of(context)
        .pushNamed(RouteNames.studentDetailsScreen, arguments: studentId);

    if (!context.mounted) return;
    cubit.refresh();
  }

  void _openGradeFilter(BuildContext context, StudentsCubit cubit) {
    Navigator.of(context)
        .pushNamed(RouteNames.studentsGradeFilterScreen, arguments: cubit);
  }
}
