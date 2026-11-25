import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/app_loading_indicator.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/students_details_body.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_header.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_states/students_failure_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsDetailsScreenContent extends StatelessWidget {
  const StudentsDetailsScreenContent({super.key});

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
              child: StudentsHeader(
                title: 'إعدادات الطلاب',
                subtitle: 'بيانات الحساب والصلاحيات',
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
                child: _DetailsStateBody(state: state, cubit: cubit),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailsStateBody extends StatelessWidget {
  const _DetailsStateBody({required this.state, required this.cubit});

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
              title: 'جارٍ تحميل بيانات الطالب...',
            ),
          ),
        );

      case StudentDetailsStatus.failure:
        return StudentsFailureState(
          title: 'تعذّر تحميل بيانات الطالب',
          message:
              state.errorMessage ?? 'تأكد من الاتصال بالإنترنت وأعد المحاولة.',
          onRetry: cubit.retry,
        );

      case StudentDetailsStatus.success:
        final student = state.student;

        if (student == null) {
          return StudentsFailureState(
            title: 'تعذّر تحميل بيانات الطالب',
            message: 'ارجع إلى القائمة واختر الطالب مرة أخرى.',
            onRetry: cubit.retry,
          );
        }

        return StudentsDetailsBody(student: student);
    }
  }
}
