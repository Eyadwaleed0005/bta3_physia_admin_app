import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_secondary_button.dart';
import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_widgets/live_stream_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSuccessState extends StatelessWidget {
  const LiveSuccessState({
    super.key,
    required this.live,
    required this.onEdit,
    required this.onEnd,
  });

  final LiveStreamModel live;
  final VoidCallback onEdit;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          live.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font20TextLightBoldTajawal(),
        ),
        verticalSpace(16),
        LiveStreamCard(live: live),
        verticalSpace(16),
        CustomSecondaryButton(
          text: 'تعديل بيانات البث',
          onPressed: onEdit,
          height: 50.h,
          backgroundColor: ColorPalette.panelGlass,
          borderColor: ColorPalette.border,
          borderRadius: 24.r,
          foregroundColor: ColorPalette.textLight,
          textStyle: AppTextStyle.font15TextLightBoldTajawal(),
        ),
        verticalSpace(12),
        CustomButton(
          text: 'إنهاء البث',
          onPressed: onEnd,
          height: 50.h,
          background: ColorPalette.accent,
          foreground: ColorPalette.textPrimary,
          borderRadius: 24.r,
          textStyle: AppTextStyle.font15TextPrimaryBoldTajawal(),
        ),
        verticalSpace(16),
        AppInfoCard(
          color: ColorPalette.panelGlass,
          title: 'بث واحد فقط',
          text: 'أنهِ البث الحالي قبل إنشاء بث جديد لصف آخر.',
          titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
        ),
      ],
    );
  }
}
