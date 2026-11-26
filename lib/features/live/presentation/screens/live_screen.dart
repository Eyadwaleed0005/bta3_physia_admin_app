import 'package:bta3_physia_admin/core/helper/app_system_ui.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/background/app_screen_backdrop.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.screenBackground,
        body: SafeArea(
          child: AppScreenBackdrop(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: const LiveScreenContent(),
            ),
          ),
        ),
      ),
    );
  }
}
