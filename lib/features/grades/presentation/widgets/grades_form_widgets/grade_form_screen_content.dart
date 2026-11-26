import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/app_toast.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/core/widgets/custom_text_form_field.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_state.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_dialogs/grades_dialogs.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_form_widgets/grade_activation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeFormScreenContent extends StatefulWidget {
  const GradeFormScreenContent({super.key, this.grade});

  final GradeModel? grade;

  @override
  State<GradeFormScreenContent> createState() => _GradeFormScreenContentState();
}

class _GradeFormScreenContentState extends State<GradeFormScreenContent> {
  static const double _bottomContentInset = 24;

  late final TextEditingController _nameController;

  String? _error;

  bool get _isEditing => widget.grade != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.grade?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final String name = _nameController.text.trim();
    final GradesCubit cubit = context.read<GradesCubit>();

    if (name.isEmpty) {
      setState(() => _error = 'اكتب اسم الصف أولاً.');
      return;
    }

    if (cubit.isNameTaken(name, excludeId: widget.grade?.id)) {
      setState(() => _error = 'يوجد صف بهذا الاسم بالفعل.');
      return;
    }

    setState(() => _error = null);
    FocusScope.of(context).unfocus();

    if (_isEditing) {
      cubit.renameGrade(widget.grade!.id, name);
    } else {
      cubit.addGrade(name);
    }

    showAppToast(context, message: 'تم حفظ التغييرات');
    Navigator.of(context).pop();
  }

  void _clearError(String _) {
    if (_error == null) return;

    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradesCubit, GradesState>(
      builder: (BuildContext context, GradesState state) {
        final GradeModel? currentGrade = _isEditing
            ? (state.gradeById(widget.grade!.id) ?? widget.grade)
            : null;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: CustomScreenHeader(
                title: 'إضافة وتعديل الصف',
                subtitle: 'إدارة المحتوى والبيانات',
                onBack: () => Navigator.of(context).pop(),
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
                      controller: _nameController,
                      labelText: 'اسم الصف',
                      hintText: 'اكتب اسم الصف',
                      isRequired: true,
                      errorText: _error,
                      textInputAction: TextInputAction.done,
                      onChanged: _clearError,
                      onSubmitted: (_) => _handleSave(),
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
                    const AppInfoCard(
                      color: ColorPalette.panelGlass,

                      title: 'تعديل الاسم يحفظ العلاقات',
                      text:
                          'الطلاب والكورسات تظل مرتبطة بالصف نفسه عند تغيير '
                          'اسمه.',
                    ),
                    verticalSpace(18),
                    CustomButton(
                      text: 'حفظ الصف',
                      onPressed: _handleSave,
                      height: 52.h,
                      background: ColorPalette.accent,
                      foreground: ColorPalette.textPrimary,
                      borderRadius: 24.r,
                      textStyle: AppTextStyle.font15TextPrimaryBoldTajawal(),
                    ),
                    if (currentGrade != null) ...[
                      verticalSpace(16),
                      GradeActivationCard(
                        grade: currentGrade,
                        onTap: () =>
                            showGradeActivationDialog(context, currentGrade),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
