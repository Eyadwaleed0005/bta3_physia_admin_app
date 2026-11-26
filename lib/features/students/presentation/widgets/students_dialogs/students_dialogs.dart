import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/app_toast.dart';
import 'package:bta3_physia_admin/core/widgets/custom_dialog.dart';
import 'package:bta3_physia_admin/core/widgets/custom_text_form_field.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/core/widgets/app_action_tile.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_details_widgets/student_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showStudentGradeDialog(
  BuildContext context,
  StudentModel student,
) {
  final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();

  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (BuildContext dialogContext) {
      final List<GradeModel> alternativeGrades = cubit.state.availableGrades
          .where((GradeModel grade) => grade.id != student.gradeId)
          .toList(growable: false);

      return CustomDialog(
        title: 'تغيير الصف الدراسي',
        subtitle: 'راجع البيانات قبل المتابعة',
        showPrimaryButton: false,
        showSecondaryButton: false,
        maxHeightFactor: 0.9,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            StudentProfileCard(student: student),
            verticalSpace(18),
            Text(
              'تعديل الصف الدراسي',
              style: AppTextStyle.font16TextLightBoldTajawal(),
            ),
            verticalSpace(12),
            AppActionTile(
              icon: Icons.school_outlined,
              title: 'الصف الحالي',
              subtitle: student.gradeLabel,
              isSelected: true,
              onTap: () {},
            ),
            if (alternativeGrades.isNotEmpty) ...[
              verticalSpace(10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: alternativeGrades.length,
                itemBuilder: (BuildContext context, int index) {
                  final GradeModel grade = alternativeGrades[index];

                  return AppActionTile(
                    icon: Icons.school_outlined,
                    title: grade.name,
                    subtitle: 'اختيار الصف الجديد',
                    onTap: () => _confirmGradeChange(
                      dialogContext: dialogContext,
                      cubit: cubit,
                      student: student,
                      grade: grade,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    verticalSpace(10),
              ),
            ],
          ],
        ),
      );
    },
  );
}

Future<void> _confirmGradeChange({
  required BuildContext dialogContext,
  required StudentDetailsCubit cubit,
  required StudentModel student,
  required GradeModel grade,
}) async {
  final bool? confirmed = await CustomDialog.showConfirm(
    dialogContext,
    title: 'تأكيد تغيير الصف',
    subtitle: 'راجع البيانات قبل المتابعة',
    primaryText: 'تأكيد تغيير الصف',
    showSecondaryButton: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'تأكيد تغيير الصف؟',
          textAlign: TextAlign.center,
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        Text(
          student.name,
          textAlign: TextAlign.center,
          style: AppTextStyle.font16TextLightBoldTajawal(),
        ),
        verticalSpace(4),
        Text(
          grade.name,
          textAlign: TextAlign.center,
          style: AppTextStyle.font14TextSecondaryBoldTajawal(),
        ),
        verticalSpace(16),
        const AppInfoCard(
          text:
              'هيتغير المحتوى المتاح وسجل نتائج الصف الحالي. تفعيلات '
              'الصف القديم لا تمنح الوصول من الصف الجديد.',
        ),
      ],
    ),
  );

  if (confirmed == true && dialogContext.mounted) {
    cubit.changeGrade(grade.id);
    showAppToast(dialogContext, message: 'تم حفظ إعدادات الطالب');
    Navigator.of(dialogContext).pop();
  }
}

Future<void> showStudentPasswordDialog(
  BuildContext context,
  StudentModel student,
) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (BuildContext dialogContext) =>
        _StudentPasswordDialog(student: student),
  );
}

class _StudentPasswordDialog extends StatefulWidget {
  const _StudentPasswordDialog({required this.student});

  final StudentModel student;

  @override
  State<_StudentPasswordDialog> createState() => _StudentPasswordDialogState();
}

class _StudentPasswordDialogState extends State<_StudentPasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final String password = _passwordController.text;
    final String confirmation = _confirmController.text;

    if (password.trim().isEmpty || confirmation.trim().isEmpty) {
      setState(() => _error = 'أدخل كلمة المرور وتأكيدها.');
      return;
    }

    if (password != confirmation) {
      setState(() => _error = 'كلمتا المرور غير متطابقتين.');
      return;
    }

    setState(() => _error = null);

    final bool? confirmed = await CustomDialog.showConfirm(
      context,
      title: 'تأكيد تغيير كلمة المرور',
      subtitle: 'راجع البيانات قبل المتابعة',
      primaryText: 'تأكيد',
      secondaryText: 'إلغاء',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تغيير كلمة مرور الطالب؟',
            style: AppTextStyle.font18TextLightBoldTajawal(),
          ),
          verticalSpace(12),
          Text(
            widget.student.name,
            style: AppTextStyle.font16TextLightBoldTajawal(),
          ),
          verticalSpace(16),
          const AppInfoCard(
            text: 'هيستخدم الطالب كلمة المرور الجديدة عند تسجيل الدخول.',
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    showAppToast(context, message: 'تم حفظ إعدادات الطالب');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'تغيير كلمة المرور',
      subtitle: 'راجع البيانات قبل المتابعة',
      primaryButtonText: 'متابعة',
      showSecondaryButton: false,
      maxHeightFactor: 0.9,
      onPrimaryPressed: _handleContinue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'كلمة مرور جديدة',
            style: AppTextStyle.font18TextLightBoldTajawal(),
          ),
          verticalSpace(12),
          Text(
            widget.student.name,
            style: AppTextStyle.font16TextLightBoldTajawal(),
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _passwordController,
            labelText: 'كلمة المرور الجديدة',
            hintText: 'أدخل كلمة المرور',
            obscureText: true,
            showPasswordCopyIcon: false,
            textInputAction: TextInputAction.next,
            fillColor: ColorPalette.fieldFill,
            borderColor: ColorPalette.fieldBorder,
            focusedBorderColor: ColorPalette.teal200,
            textStyle: AppTextStyle.font14CreamRegularTajawal(),
            hintStyle: AppTextStyle.font13TextMutedRegularTajawal(),
            labelStyle: AppTextStyle.font13TextLightSemiBoldTajawal(),
            cursorColor: ColorPalette.accent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
          verticalSpace(12),
          CustomTextFormField(
            controller: _confirmController,
            labelText: 'تأكيد كلمة المرور',
            hintText: 'أدخل كلمة المرور',
            obscureText: true,
            showPasswordCopyIcon: false,
            textInputAction: TextInputAction.done,
            fillColor: ColorPalette.fieldFill,
            borderColor: ColorPalette.fieldBorder,
            focusedBorderColor: ColorPalette.teal200,
            textStyle: AppTextStyle.font14CreamRegularTajawal(),
            hintStyle: AppTextStyle.font13TextMutedRegularTajawal(),
            labelStyle: AppTextStyle.font13TextLightSemiBoldTajawal(),
            cursorColor: ColorPalette.accent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
          if (_error != null) ...[
            verticalSpace(10),
            Text(
              _error!,
              textAlign: TextAlign.start,
              style: AppTextStyle.font12ErrorRegularTajawal(),
            ),
          ],
          verticalSpace(16),
          AppInfoCard(
            text: 'لن تظهر كلمة المرور الحالية. يتم تعيين كلمة مرور جديدة بعد التأكيد.',
          ),
        ],
      ),
    );
  }
}

Future<void> showAccountStatusDialog(
  BuildContext context,
  StudentModel student,
) async {
  final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();
  final bool isPausing = student.isActive;

  final bool? confirmed = await CustomDialog.showConfirm(
    context,
    title: isPausing ? 'إيقاف حساب الطالب؟' : 'إعادة تفعيل حساب الطالب؟',
    subtitle: 'راجع البيانات قبل المتابعة',
    primaryText: 'تأكيد',
    secondaryText: 'إلغاء',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isPausing ? 'إيقاف حساب الطالب؟' : 'إعادة تفعيل الحساب؟',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        Text(student.name, style: AppTextStyle.font16TextLightBoldTajawal()),
        verticalSpace(16),
        AppInfoCard(
          text: isPausing
              ? 'لن يتمكن الطالب من استخدام الحساب حتى تعيد تفعيله. '
                    'تفعيلات الكورسات ستظل محفوظة.'
              : 'هيستخدم الطالب حسابه مرة أخرى.',
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    cubit.toggleAccountStatus();
    showAppToast(
      context,
      message: isPausing ? 'تم إيقاف تفعيل الحساب' : 'تم إعاده تفعيل الحساب',
    );
  }
}

Future<void> showLoginLinkDialog(
  BuildContext context,
  StudentModel student,
) async {
  final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();
  final bool isLinked = student.isLoginLinked;

  final bool? confirmed = await CustomDialog.showConfirm(
    context,
    title: isLinked ? 'فك ربط تسجيل الدخول؟' : 'ربط تسجيل الدخول؟',
    subtitle: 'راجع البيانات قبل المتابعة',
    primaryText: isLinked ? 'فك ربط' : 'ربط',
    secondaryText: 'إلغاء',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isLinked ? 'فك ربط تسجيل الدخول؟' : 'ربط تسجيل الدخول؟',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        Text(student.name, style: AppTextStyle.font16TextLightBoldTajawal()),
        verticalSpace(16),
        AppInfoCard(
          text: isLinked
              ? 'هيتمكن الطالب من تسجيل الدخول من جديد، واشتراكاته وبياناته لن تتغير.'
              : 'هيتم ربط تسجيل الدخول بحساب الطالب من جديد.',
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    cubit.toggleLoginLink();
    showAppToast(
      context,
      message: isLinked
          ? 'تم فك تسجيل دخول الحساب'
          : 'تم ربط تسجيل دخول الحساب',
    );
  }
}

Future<void> showDeleteStudentDialog(
  BuildContext context,
  StudentModel student,
) async {
  final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();

  final bool? confirmed = await CustomDialog.showDelete(
    context,
    title: 'حذف الطالب',
    subtitle: 'راجع الحساب قبل تأكيد الحذف',
    primaryText: 'حذف الطالب',
    secondaryText: 'إلغاء',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'حذف الطالب نهائيًا',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(8),
        Text(student.name, style: AppTextStyle.font18TextLightBoldTajawal()),
        verticalSpace(16),
        const AppInfoCard(
          text: 'سيحذف الطالب من الاداره و تلغي تفعيلات كورساته. لا يمكن التراجع عن هذا الأجراء.',
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    cubit.deleteStudent();
    showAppToast(
      context,
      message: 'تم حذف الطالب',
      icon: Icons.delete_outline_rounded,
    );
    Navigator.of(context).pop();
  }
}

Future<void> showActivationCourseDialog(
  BuildContext context,
  StudentModel student,
  StudentCourseModel course,
) async {
  final StudentDetailsCubit cubit = context.read<StudentDetailsCubit>();
  final bool isActive = course.isActivated;

  final bool? confirmed = await CustomDialog.showConfirm(
    context,
    title: 'الكورسات',
    subtitle: 'اداره الكورسات و الأشتراكات',
    primaryText: isActive ? 'تأكيد إلغاء التفعيل' : 'تأكيد التفعيل',
    secondaryText: 'رجوع بدون تغيير',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isActive ? 'إلغاء اشتراك الطالب' : 'ربط تسجيل الدخول؟',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        Text(student.name, style: AppTextStyle.font16TextLightBoldTajawal()),
        verticalSpace(16),
        Text(
          course.title,
          style: AppTextStyle.font14TextSecondaryBoldTajawal(),
        ),
        verticalSpace(16),
        AppInfoCard(
          text: isActive
              ? 'هيتقفل محتوي هذا الكورس المدفوع للطالب. حساب الطالب هيفضل موجود'
              : 'هيقدر الطالب يفتح متحوي هذا الكورس المدفوع.',
        ),
      ],
    ),
  );

  if (confirmed == true && context.mounted) {
    cubit.activateCourse(course.id, !isActive);
    showAppToast(
      context,
      message: isActive ? 'تم إلغاء تفعيل الكورس' : 'تم تفعيل الكورس',
    );
  }
}
