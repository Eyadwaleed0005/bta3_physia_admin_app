import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_courses_widgets/student_course_card.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_dialogs/students_dialogs.dart';
import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsCoursesBody extends StatelessWidget {
  const StudentsCoursesBody({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'الكورسات والتفعيلات',
          style: AppTextStyle.font20TextLightBoldTajawal(),
        ),
        verticalSpace(4),
        Text(
          student.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font16TextLightBoldTajawal(),
        ),
        verticalSpace(2),
        Text(
          student.gradeLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font12TextMutedRegularTajawal(),
        ),
        verticalSpace(18),
        if (student.courses.isEmpty)
          const AppNoticeCard(
            title: 'لا توجد كورسات',
            message: 'لم يتم تفعيل أي كورس لهذا الطالب بعد.',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: student.courses.length,
            itemBuilder: (BuildContext context, int index) {
              final StudentCourseModel course = student.courses[index];

              return StudentCourseCard(
                course: course,
                openDialog: () =>
                    showActivationCourseDialog(context, student, course),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                verticalSpace(14),
          ),
        verticalSpace(4),
        Text(
          'تفعيل الكورس يمنح الطالب الوصول للمحتوى والامتحانات الخاصة به.',
          textAlign: TextAlign.center,
          style: AppTextStyle.font13TextMutedRegularTajawal(),
        ),
      ],
    );
  }
}
