import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';

class LiveLoadingState extends StatelessWidget {
  const LiveLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: AppLoadingIndicator(
          color: ColorPalette.teal200,
          size: 18,
          title: 'جارٍ تحميل البث...',
        ),
      ),
    );
  }
}
