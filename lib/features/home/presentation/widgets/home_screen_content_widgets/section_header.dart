import 'package:bta3_physia_admin/core/helper/app_date_time_formatter.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, this.lastUpdatedAt});

  final DateTime? lastUpdatedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اشتراكات الكورسات',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.font16TextLightBoldTajawal(),
              ),
              verticalSpace(4),
              Text(
                'التفعيلات الحالية للكورسات المدفوعة',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.font12TextMutedRegularTajawal(),
              ),
            ],
          ),
        ),
        horizontalSpace(12),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            _updatedLabel(),
            maxLines: 1,
            style: AppTextStyle.font11TextMutedRegularTajawal(),
          ),
        ),
      ],
    );
  }

  String _updatedLabel() {
    final DateTime? updatedAt = lastUpdatedAt;

    if (updatedAt == null ||
        DateTime.now().difference(updatedAt).inMinutes < 1) {
      return 'آخر تحديث الآن';
    }

    return 'آخر تحديث ${AppDateTimeFormatter.formatTime(updatedAt)}';
  }
}
