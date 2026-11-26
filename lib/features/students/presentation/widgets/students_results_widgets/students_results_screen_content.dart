import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/app_loading_indicator.dart';
import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_profile_card.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_results_widgets/student_result_card.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_failure_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsResultsScreenContent extends StatelessWidget {
  const StudentsResultsScreenContent({super.key});

  static const double _bottomContentInset = 24;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentDetailsCubit, StudentDetailsState>(
      builder: (BuildContext context, StudentDetailsState state) {
        final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: CustomScreenHeader(
                title: 'سجل النتائج',
                subtitle: 'نتائج امتحانات الصف الحالي',
                onBack: () => Navigator.of(context).pop(),
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
                child: _ResultsStateBody(state: state, cubit: cubit),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ResultsStateBody extends StatelessWidget {
  const _ResultsStateBody({required this.state, required this.cubit});

  final StudentDetailsState state;
  final StudentDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case StudentDetailsStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: AppLoadingIndicator(
              color: ColorPalette.teal200,
              size: 18,
              title: 'جارٍ تحميل النتائج...',
            ),
          ),
        );

      case StudentDetailsStatus.failure:
        return StudentsFailureState(
          title: 'تعذّر تحميل نتائج الطالب',
          message:
              state.errorMessage ?? 'تأكد من الاتصال بالإنترنت وأعد المحاولة.',
          onRetry: cubit.retry,
        );

      case StudentDetailsStatus.success:
        final StudentModel student = state.student!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            StudentProfileCard(student: student),
            verticalSpace(16),
            if (student.results.isEmpty)
              const AppNoticeCard(
                title: 'لا توجد نتائج مسجلة',
                message:
                    'ستظهر نتائج امتحانات الطالب هنا بعد إتمام أول امتحان.',
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: student.results.length,
                itemBuilder: (BuildContext context, int index) =>
                    StudentResultCard(result: student.results[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    verticalSpace(12),
              ),
          ],
        );
    }
  }
}
