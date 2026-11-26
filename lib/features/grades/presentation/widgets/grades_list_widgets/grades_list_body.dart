import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_state.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_list_widgets/grade_card.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_states/grades_empty_state.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_states/grades_failure_state.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_states/grades_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradesListBody extends StatelessWidget {
  const GradesListBody({
    super.key,
    required this.state,
    required this.onOpenGrade,
  });

  final GradesState state;
  final ValueChanged<GradeModel> onOpenGrade;

  @override
  Widget build(BuildContext context) {
    final GradesCubit cubit = context.read<GradesCubit>();

    switch (state.status) {
      case GradesStatus.loading:
        return const GradesLoadingState();

      case GradesStatus.failure:
        return GradesFailureState(
          message:
              state.errorMessage ?? 'تأكد من الاتصال بالإنترنت وأعد المحاولة.',
          onRetry: cubit.load,
        );

      case GradesStatus.empty:
        return const GradesEmptyState();

      case GradesStatus.success:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: state.grades.length,
              itemBuilder: (BuildContext context, int index) {
                final GradeModel grade = state.grades[index];

                return GradeCard(grade: grade, onTap: () => onOpenGrade(grade));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  verticalSpace(12),
            ),
            verticalSpace(12),
            AppInfoCard(
              color: ColorPalette.panelGlass,

              title: 'قائمة واحدة في التطبيقين',
              text:
                  'تستخدم الصفوف نفسها في التسجيل والفلترة والكورسات '
                  'والامتحانات والنتائج.',

              titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
            ),
          ],
        );
    }
  }
}
