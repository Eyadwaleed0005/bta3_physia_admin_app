import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_dialog.dart';
import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_dialogs/live_selection_row.dart';
import 'package:flutter/material.dart';

enum LiveLeaveAction { save, discard }

const Color _barrierColor = Color(0x8C000000);

AppInfoCard _dialogNotice({required String title, required String message}) {
  return AppInfoCard(
    title: title,
    text: message,
    titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
  );
}

Future<bool?> showLiveBusyDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierColor: _barrierColor,
    builder: (BuildContext dialogContext) {
      return CustomDialog(
        title: 'يوجد بث حالي بالفعل',
        subtitle: 'يمكنك إعادة المحاولة',
        primaryButtonText: 'عرض البث الحالي',
        showSecondaryButton: false,
        maxHeightFactor: 0.9,
        body: _dialogNotice(
          title: 'أنهِ البث الحالي أولًا',
          message:
              'يوجد بث منشور في التطبيق. يمكنك تعديل بياناته أو إنهاؤه قبل '
              'إنشاء بث آخر.',
        ),
        onPrimaryPressed: () => Navigator.of(dialogContext).pop(true),
      );
    },
  );
}

Future<bool?> showLiveEndDialog(BuildContext context) {
  return CustomDialog.showConfirm(
    context,
    title: 'إنهاء البث الحالي؟',
    subtitle: 'راجع البيانات قبل المتابعة',
    primaryText: 'تأكيد إنهاء البث',
    secondaryText: 'الاحتفاظ بالبث',
    body: _dialogNotice(
      title: 'إنهاء البث داخل التطبيق',
      message:
          'لن ينهي هذا الإجراء الاجتماع في Zoom أو Google Meet. يمكنك إنشاء '
          'بث جديد بعد إزالة البث الحالي.',
    ),
  );
}

Future<void> showLiveInvalidDialog(BuildContext context) {
  return CustomDialog.showNotice(
    context,
    title: 'راجع عنوان البث والرابط',
    subtitle: 'يمكنك إعادة المحاولة',
    buttonText: 'تعديل بيانات البث',
    body: _dialogNotice(
      title: 'عنوان ورابط صحيحان مطلوبان',
      message:
          'أدخل عنوانًا ورابطًا للمنصة المختارة. تأكد من أن رابط Zoom أو '
          'Google Meet تم اعتماده.',
    ),
  );
}

Future<LiveLeaveAction?> showLiveLeaveDialog(BuildContext context) {
  return showDialog<LiveLeaveAction>(
    context: context,
    barrierColor: _barrierColor,
    builder: (BuildContext dialogContext) {
      return CustomDialog(
        title: 'تغييرات البث غير محفوظة',
        subtitle: 'راجع البيانات قبل المتابعة',
        primaryButtonText: 'حفظ بيانات البث',
        secondaryButtonText: 'تجاهل التغييرات',
        tertiaryButtonText: 'متابعة التحرير',
        maxHeightFactor: 0.9,
        body: _dialogNotice(
          title: 'البث الحالي يحتفظ ببياناته',
          message: 'يمكنك حفظ التعديلات أو تجاهلها أو متابعة التحرير.',
        ),
        onPrimaryPressed: () =>
            Navigator.of(dialogContext).pop(LiveLeaveAction.save),
        onSecondaryPressed: () =>
            Navigator.of(dialogContext).pop(LiveLeaveAction.discard),
        onTertiaryPressed: () => Navigator.of(dialogContext).pop(),
      );
    },
  );
}

Future<GradeModel?> showLiveGradeDialog(BuildContext context) {
  final List<GradeModel> grades = DummyGradesData.activeGrades;

  return showDialog<GradeModel>(
    context: context,
    barrierColor: _barrierColor,
    builder: (BuildContext dialogContext) {
      return CustomDialog(
        title: 'صف البث',
        subtitle: 'راجع البيانات قبل المتابعة',
        showPrimaryButton: false,
        showSecondaryButton: false,
        maxHeightFactor: 0.9,
        body: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: grades.length,
          itemBuilder: (BuildContext context, int index) {
            final GradeModel grade = grades[index];

            return LiveSelectionRow(
              icon: Icons.school_outlined,
              title: grade.name,
              subtitle: 'اختيار الصف',
              onTap: () => Navigator.of(dialogContext).pop(grade),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              verticalSpace(6),
        ),
      );
    },
  );
}

Future<LivePlatform?> showLiveProviderDialog(BuildContext context) {
  return showDialog<LivePlatform>(
    context: context,
    barrierColor: _barrierColor,
    builder: (BuildContext dialogContext) {
      return CustomDialog(
        title: 'منصة البث',
        subtitle: 'راجع البيانات قبل المتابعة',
        showPrimaryButton: false,
        showSecondaryButton: false,
        maxHeightFactor: 0.9,
        body: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: LivePlatform.values.length,
          itemBuilder: (BuildContext context, int index) {
            final LivePlatform platform = LivePlatform.values[index];

            return LiveSelectionRow(
              icon: Icons.person_outline_rounded,
              title: platform.label,
              subtitle: platform.externalLabel,
              onTap: () => Navigator.of(dialogContext).pop(platform),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              verticalSpace(6),
        ),
      );
    },
  );
}
