import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_action_tile.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_profile_card.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_dialogs/students_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsDetailsBody extends StatelessWidget {
  const StudentsDetailsBody({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        StudentProfileCard(student: student),
        verticalSpace(16),
        CustomButton(
          text: 'الكورسات والتفعيلات',
          onPressed: () =>
              Navigator.of(context)
                  .pushNamed(RouteNames.studentCoursesScreen, arguments: cubit),
          height: 50.h,
          background: ColorPalette.accent,
          foreground: ColorPalette.textPrimary,
          borderRadius: 24.r,
          textStyle: AppTextStyle.font15TextPrimaryBoldTajawal(),
        ),
        verticalSpace(16),
        StudentActionTile(
          icon: Icons.bar_chart_rounded,
          title: 'سجل النتائج',
          subtitle: 'نتائج امتحانات الصف الحالي',
          onTap: () =>
              Navigator.of(context)
                  .pushNamed(RouteNames.studentResultsScreen, arguments: cubit),
        ),
        verticalSpace(10),
        CustomButton(
          text: 'حذف الطالب',
          onPressed: () => showDeleteStudentDialog(context, student),
          height: 50.h,
          background: ColorPalette.fieldFill,
          borderRadius: 24.r,
          borderColor: ColorPalette.border,
          textStyle: AppTextStyle.font18TextPrimaryBoldTajawal(),
        ),
        verticalSpace(10),
        StudentActionTile(
          icon: Icons.school_outlined,
          title: 'تغيير الصف الدراسي',
          subtitle: 'تحديث الصف والمحتوى المتاح',
          onTap: () => showStudentGradeDialog(context, student),
        ),
        verticalSpace(10),
        StudentActionTile(
          icon: Icons.lock_outline_rounded,
          title: 'تغيير كلمة المرور',
          subtitle: 'تعيين كلمة مرور جديدة للحساب',
          onTap: () => showStudentPasswordDialog(context, student),
        ),
        verticalSpace(10),
        StudentActionTile(
          icon: student.isActive
              ? Icons.pause_circle_outline_rounded
              : Icons.play_circle_outline_rounded,
          title: student.isActive ? 'إيقاف الحساب' : 'إعادة تفعيل الحساب',
          subtitle: student.isActive
              ? 'منع الطالب من استخدام الحساب'
              : 'السماح للطالب باستخدام الحساب',
          onTap: () => showAccountStatusDialog(context, student),
        ),
        verticalSpace(10),
        StudentActionTile(
          icon: student.isLoginLinked
              ? Icons.link_off_rounded
              : Icons.link_rounded,
          title: student.isLoginLinked
              ? 'فك ربط تسجيل الدخول'
              : 'ربط تسجيل الدخول',
          subtitle: student.isLoginLinked
              ? 'ربط الدخول مفعل'
              : 'ربط الدخول غير مفعل',
          onTap: () => showLoginLinkDialog(context, student),
        ),
      ],
    );
  }
}
