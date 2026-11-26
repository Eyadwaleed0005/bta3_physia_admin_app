import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_action_tile.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/app_toast.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/core/widgets/custom_text_form_field.dart';
import 'package:bta3_physia_admin/features/grades/data/models/dummy_grades_data.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:bta3_physia_admin/features/live/presentation/cubit/live_cubit.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_dialogs/live_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveFormScreenContent extends StatefulWidget {
  const LiveFormScreenContent({super.key, this.initialLive});

  final LiveStreamModel? initialLive;

  @override
  State<LiveFormScreenContent> createState() => _LiveFormScreenContentState();
}

class _LiveFormScreenContentState extends State<LiveFormScreenContent> {
  static const double _bottomContentInset = 24;

  late final TextEditingController _titleController;
  late final TextEditingController _urlController;

  GradeModel? _selectedGrade;
  LivePlatform? _selectedPlatform;

  late final String _initialTitle;
  late final String _initialUrl;
  String? _initialGradeId;
  LivePlatform? _initialPlatform;

  bool get _isDirty {
    return _titleController.text.trim() != _initialTitle ||
        _urlController.text.trim() != _initialUrl ||
        _selectedGrade?.id != _initialGradeId ||
        _selectedPlatform != _initialPlatform;
  }

  @override
  void initState() {
    super.initState();

    final LiveStreamModel? live = widget.initialLive;

    _titleController = TextEditingController(text: live?.title ?? '');
    _urlController = TextEditingController(text: live?.url ?? '');
    _selectedGrade = live == null
        ? null
        : DummyGradesData.findById(live.gradeId);
    _selectedPlatform = live?.platform;

    _initialTitle = _titleController.text.trim();
    _initialUrl = _urlController.text.trim();
    _initialGradeId = _selectedGrade?.id;
    _initialPlatform = _selectedPlatform;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _handleFieldChanged(String _) {
    setState(() {});
  }

  Future<void> _handleBack() async {
    if (!_isDirty) {
      Navigator.of(context).pop();
      return;
    }

    final LiveLeaveAction? action = await showLiveLeaveDialog(context);

    if (!mounted || action == null) return;

    switch (action) {
      case LiveLeaveAction.save:
        await _handleSave();
      case LiveLeaveAction.discard:
        Navigator.of(context).pop();
    }
  }

  Future<void> _handleSave() async {
    final String title = _titleController.text.trim();
    final String url = _urlController.text.trim();
    final GradeModel? grade = _selectedGrade;
    final LivePlatform? platform = _selectedPlatform;

    if (title.isEmpty || grade == null || platform == null) {
      await showLiveInvalidDialog(context);
      return;
    }

    if (!_isValidUrl(url, platform)) {
      await showLiveInvalidDialog(context);
      return;
    }

    final LiveCubit cubit = context.read<LiveCubit>();

    if (widget.initialLive == null && cubit.state.live != null) {
      final bool? viewCurrent = await showLiveBusyDialog(context);

      if (!mounted) return;
      if (viewCurrent == true) {
        cubit.load();
        Navigator.of(context).pop();
      }
      return;
    }

    cubit.saveLive(
      LiveStreamModel(
        title: title,
        gradeId: grade.id,
        platform: platform,
        url: url,
      ),
    );

    if (!mounted) return;

    showAppToast(
      context,
      message: widget.initialLive == null
          ? 'تم نشر البث'
          : 'تم حفظ بيانات البث',
    );
    Navigator.of(context).pop();
  }

  bool _isValidUrl(String value, LivePlatform platform) {
    return platform.matchesUrl(value);
  }

  Future<void> _openGradePicker() async {
    final GradeModel? grade = await showLiveGradeDialog(context);

    if (grade != null && mounted) {
      setState(() => _selectedGrade = grade);
    }
  }

  Future<void> _openProviderPicker() async {
    final LivePlatform? platform = await showLiveProviderDialog(context);

    if (platform != null && mounted) {
      setState(() => _selectedPlatform = platform);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;

        _handleBack();
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: CustomScreenHeader(
              title: 'إنشاء وتعديل البث',
              subtitle: 'إدارة المحتوى والبيانات',
              onBack: () => _handleBack(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                20.w,
                8.h,
                20.w,
                _bottomContentInset.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: _titleController,
                    labelText: 'عنوان البث',
                    hintText: 'اكتب عنوان البث',
                    textInputAction: TextInputAction.next,
                    onChanged: _handleFieldChanged,
                    fillColor: ColorPalette.fieldFill,
                    borderColor: ColorPalette.fieldBorder,
                    focusedBorderColor: ColorPalette.teal200,
                    textStyle: AppTextStyle.font14CreamRegularTajawal(),
                    hintStyle: AppTextStyle.font13TextMutedRegularTajawal(),
                    labelStyle: AppTextStyle.font13TextLightSemiBoldTajawal(),
                    cursorColor: ColorPalette.accent,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                  verticalSpace(16),
                  AppActionTile(
                    icon: Icons.school_outlined,
                    title: 'الصف الدراسي',
                    subtitle: _selectedGrade?.name ?? 'اختر الصف',
                    showBorder: true,
                    onTap: () => _openGradePicker(),
                  ),
                  verticalSpace(12),
                  AppActionTile(
                    icon: Icons.live_tv_rounded,
                    title: 'منصة البث',
                    subtitle: _selectedPlatform?.label ?? 'اختر المنصة',
                    showBorder: true,
                    onTap: () => _openProviderPicker(),
                  ),
                  verticalSpace(16),
                  CustomTextFormField(
                    controller: _urlController,
                    labelText: 'رابط البث',
                    hintText: 'https://...',
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    onChanged: _handleFieldChanged,
                    fillColor: ColorPalette.fieldFill,
                    borderColor: ColorPalette.fieldBorder,
                    focusedBorderColor: ColorPalette.teal200,
                    textStyle: AppTextStyle.font14CreamRegularTajawal(),
                    hintStyle: AppTextStyle.font13TextMutedRegularTajawal(),
                    labelStyle: AppTextStyle.font13TextLightSemiBoldTajawal(),
                    cursorColor: ColorPalette.accent,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                  verticalSpace(16),
                  AppInfoCard(
                    color: ColorPalette.panelGlass,
                    title: 'إنهاء البث يدويًا',
                    text:
                        'انتهاء الاجتماع على Zoom أو Google Meet لا يخفي '
                        'البث من التطبيق. أنهِ البث من هنا.',
                    titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
                  ),
                  verticalSpace(18),
                  CustomButton(
                    text: 'حفظ ونشر البث',
                    onPressed: () => _handleSave(),
                    height: 52.h,
                    background: ColorPalette.accent,
                    foreground: ColorPalette.textPrimary,
                    borderRadius: 24.r,
                    textStyle: AppTextStyle.font15TextPrimaryBoldTajawal(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
