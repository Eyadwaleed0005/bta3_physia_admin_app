import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsFilterButton extends StatelessWidget {
  const StudentsFilterButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(16.r);

    return Material(
      color: ColorPalette.fieldFill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          width: 52.w,
          height: 52.h,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isActive ? ColorPalette.accent : ColorPalette.fieldBorder,
              width: 1.w,
            ),
          ),
          child: Icon(
            Icons.filter_alt_outlined,
            size: 22.r,
            color: isActive ? ColorPalette.accent : ColorPalette.teal200,
          ),
        ),
      ),
    );
  }
}
