import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_action_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsGradeFilterScreenContent extends StatelessWidget {
  final StudentsCubit cubit;

  const StudentsGradeFilterScreenContent({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final GradeModel? currentGrade = cubit.state.gradeFilter;
    final List<GradeModel> grades = cubit.state.availableGrades;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: CustomScreenHeader(
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: grades.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return StudentActionTile(
                        icon: Icons.school_outlined,
                        title: 'كل الصفوف',
                        subtitle: 'عرض جميع الطلاب',
                        isSelected: currentGrade == null,
                        onTap: () {
                          cubit.selectGrade(null);
                          Navigator.of(context).pop();
                        },
                      );
                    }

                    final GradeModel grade = grades[index - 1];

                    return StudentActionTile(
                      icon: Icons.school_outlined,
                      title: grade.name,
                      subtitle: 'عرض طلاب هذا الصف',
                      isSelected: currentGrade?.id == grade.id,
                      onTap: () {
                        cubit.selectGrade(grade);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      verticalSpace(10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
