import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_action_tile.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsGradeFilterScreenContent extends StatelessWidget {
  final StudentsCubit cubit;

  const StudentsGradeFilterScreenContent({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final StudentGrade? currentGrade = cubit.state.gradeFilter;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: StudentsHeader(
            title: 'الطلاب',
            subtitle: 'إدارة الطلاب والتفعيلات',
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'اختر الصف الدراسي',
                  style: AppTextStyle.font20TextLightBoldTajawal(),
                ),
                verticalSpace(16),
                StudentActionTile(
                  icon: Icons.school_outlined,
                  title: 'كل الصفوف',
                  subtitle: 'عرض جميع الطلاب',
                  isSelected: currentGrade == null,
                  onTap: () {
                    cubit.selectGrade(null);
                    Navigator.of(context).pop();
                  },
                ),
                verticalSpace(10),
                for (final StudentGrade grade in StudentGrade.values) ...[
                  StudentActionTile(
                    icon: Icons.school_outlined,
                    title: grade.label,
                    subtitle: 'عرض طلاب هذا الصف',
                    isSelected: currentGrade == grade,
                    onTap: () {
                      cubit.selectGrade(grade);
                      Navigator.of(context).pop();
                    },
                  ),
                  verticalSpace(10),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
