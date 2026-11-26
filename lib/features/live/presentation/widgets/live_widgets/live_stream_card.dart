import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveStreamCard extends StatelessWidget {
  const LiveStreamCard({super.key, required this.live});

  final LiveStreamModel live;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorPalette.panelGlass,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _LiveInfoField(label: 'الصف', value: live.gradeName),
          verticalSpace(12),
          _LiveInfoField(label: 'المنصة', value: live.platform.label),
          verticalSpace(12),
          _LiveInfoField(label: 'الرابط', value: live.url, isLtr: true),
        ],
      ),
    );
  }
}

class _LiveInfoField extends StatelessWidget {
  const _LiveInfoField({
    required this.label,
    required this.value,
    this.isLtr = false,
  });

  final String label;
  final String value;
  final bool isLtr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyle.font12TextMutedRegularTajawal()),
        verticalSpace(4),
        if (isLtr)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: AppTextStyle.font13TextLightSemiBoldTajawal(),
            ),
          )
        else
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.font14TextLightSemiBoldTajawal(),
          ),
      ],
    );
  }
}
