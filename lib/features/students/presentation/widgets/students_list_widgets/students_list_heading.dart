import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';

class StudentsListHeading extends StatelessWidget {
  const StudentsListHeading({
    super.key,
    required this.title,
    this.subtitle = 'اضغط على الترس لإدارة الطلاب',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(4),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font12TextMutedRegularTajawal(),
        ),
      ],
    );
  }
}
