import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24.r);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color,
        border: Border.all(color: ColorPalette.fieldBorder, width: 1.w),
      ),
      child: child,
    );
  }
}
