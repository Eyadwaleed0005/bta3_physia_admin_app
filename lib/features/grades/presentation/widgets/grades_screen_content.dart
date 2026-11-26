import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_state.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_list_widgets/grades_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradesScreenContent extends StatelessWidget {
  const GradesScreenContent({super.key});

  static const double _bottomContentInset = 24;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradesCubit, GradesState>(
      builder: (BuildContext context, GradesState state) {
        final GradesCubit cubit = context.read<GradesCubit>();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: CustomScreenHeader(
                title: 'الصفوف الدراسية',
                subtitle: 'القائمة المتاحة للطلاب والمحتوى',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الصفوف المتاحة',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font20TextLightBoldTajawal(),
                    ),
                    verticalSpace(16),
                    if (state.status != GradesStatus.failure) ...[
                      CustomButton(
                        text: 'إضافة صف',
                        onPressed: () => _openGradeForm(context, cubit, null),
                        height: 52.h,
                        background: ColorPalette.accent,
                        foreground: ColorPalette.textPrimary,
                        borderRadius: 24.r,
                        textStyle: AppTextStyle.font18TextPrimaryBoldTajawal(),
                        prefixIcon: Icon(
                          Icons.add_rounded,
                          size: 20.r,
                          color: ColorPalette.textPrimary,
                        ),
                      ),
                      verticalSpace(18),
                    ],
                    GradesListBody(
                      state: state,
                      onOpenGrade: (GradeModel grade) =>
                          _openGradeForm(context, cubit, grade),
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

  Future<void> _openGradeForm(
    BuildContext context,
    GradesCubit cubit,
    GradeModel? grade,
  ) async {
    await Navigator.of(context)
        .pushNamed(RouteNames.gradeFormScreen, arguments: grade);

    if (!context.mounted) return;
    cubit.refresh();
  }
}
