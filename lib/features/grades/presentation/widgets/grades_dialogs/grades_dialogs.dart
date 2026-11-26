import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/app_toast.dart';
import 'package:bta3_physia_admin/core/widgets/custom_dialog.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showGradeActivationDialog(
  BuildContext context,
  GradeModel grade,
) async {
  final GradesCubit cubit = context.read<GradesCubit>();
  final bool isDeactivating = grade.isActive;

  final bool? confirmed = await CustomDialog.showConfirm(
    context,
    title: isDeactivating ? 'تأكيد إيقاف الصف' : 'تأكيد تفعيل الصف',
    subtitle: 'راجع البيانات قبل المتابعة',
    primaryText: isDeactivating ? 'تأكيد إيقاف الصف' : 'تأكيد تفعيل الصف',
    secondaryText: 'رجوع بدون تغيير',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isDeactivating ? 'إيقاف الصف؟' : 'تفعيل الصف؟',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        Text(grade.name, style: AppTextStyle.font16TextLightBoldTajawal()),
        verticalSpace(16),
        AppInfoCard(
          title: isDeactivating
              ? 'ماذا يحدث بعد الإيقاف؟'
              : 'ماذا يحدث بعد التفعيل؟',
          text: isDeactivating
              ? 'لن تتمكن من مشاركة محتوى أو موارد جديدة مع هذا الصف. '
                    'حسابات الطلاب المسجلين تبقى تعمل بشكل طبيعي، لكنهم لن '
                    'يستلموا أو يروا المحتوى الذي يُشارك أثناء الإيقاف. '
                    'لن يظهر الصف في فلاتر الطلاب.'
              : 'سيصبح الصف متاحًا مرة أخرى لمشاركة المحتوى والموارد مع '
                    'طلابه، وسيظهر في فلاتر الطلاب.',
        ),
      ],
    ),
  );

  if (confirmed != true || !context.mounted) return;

  cubit.setGradeActive(grade.id, !isDeactivating);
  showAppToast(
    context,
    message: isDeactivating ? 'تم إيقاف الصف' : 'تم تفعيل الصف',
    icon: isDeactivating
        ? Icons.pause_circle_outline_rounded
        : Icons.play_circle_outline_rounded,
  );
}
