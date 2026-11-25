import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomDialogType { confirm, success, delete, notice }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.message,
    this.body,
    this.type = CustomDialogType.confirm,
    this.primaryButtonText,
    this.secondaryButtonText = 'إلغاء',
    this.showPrimaryButton = true,
    this.showSecondaryButton,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.onClose,
    this.primaryButtonColor,
    this.primaryButtonTextColor,
    this.showCloseButton = true,
    this.maxHeightFactor = 0.86,
  });

  final String title;
  final String? subtitle;
  final String? message;
  final Widget? body;
  final CustomDialogType type;

  final String? primaryButtonText;
  final String secondaryButtonText;

  final bool showPrimaryButton;
  final bool? showSecondaryButton;

  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onClose;

  final Color? primaryButtonColor;
  final Color? primaryButtonTextColor;

  final bool showCloseButton;
  final double maxHeightFactor;

  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? message,
    Widget? body,
    String primaryText = 'تأكيد',
    String secondaryText = 'إلغاء',
    bool showSecondaryButton = true,
    Color? primaryButtonColor,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (dialogContext) => CustomDialog(
        title: title,
        subtitle: subtitle,
        message: message,
        body: body,
        type: CustomDialogType.confirm,
        primaryButtonText: primaryText,
        secondaryButtonText: secondaryText,
        showSecondaryButton: showSecondaryButton,
        primaryButtonColor: primaryButtonColor,
        onPrimaryPressed: () {
          Navigator.of(dialogContext).pop(true);
          onConfirm?.call();
        },
        onSecondaryPressed: () => Navigator.of(dialogContext).pop(false),
      ),
    );
  }

  static Future<void> showNotice(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? message,
    Widget? body,
    String buttonText = 'فهمت',
    Color? primaryButtonColor,
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (dialogContext) => CustomDialog(
        title: title,
        subtitle: subtitle,
        message: message,
        body: body,
        type: CustomDialogType.notice,
        primaryButtonText: buttonText,
        primaryButtonColor: primaryButtonColor,
        showSecondaryButton: false,
        onPrimaryPressed: () {
          Navigator.of(dialogContext).pop();
          onPressed?.call();
        },
      ),
    );
  }

  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? message,
    Widget? body,
    String buttonText = 'تم',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (dialogContext) => CustomDialog(
        title: title,
        subtitle: subtitle,
        message: message,
        body: body,
        type: CustomDialogType.success,
        primaryButtonText: buttonText,
        showSecondaryButton: false,
        onPrimaryPressed: () {
          Navigator.of(dialogContext).pop();
          onPressed?.call();
        },
      ),
    );
  }

  static Future<bool?> showDelete(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? message,
    Widget? body,
    String primaryText = 'حذف',
    String secondaryText = 'إلغاء',
    VoidCallback? onDelete,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (dialogContext) => CustomDialog(
        title: title,
        subtitle: subtitle,
        message: message,
        body: body,
        type: CustomDialogType.delete,
        primaryButtonText: primaryText,
        secondaryButtonText: secondaryText,
        onPrimaryPressed: () {
          Navigator.of(dialogContext).pop(true);
          onDelete?.call();
        },
        onSecondaryPressed: () => Navigator.of(dialogContext).pop(false),
      ),
    );
  }

  String get _resolvedPrimaryText {
    if (primaryButtonText != null) return primaryButtonText!;

    return switch (type) {
      CustomDialogType.confirm => 'تأكيد',
      CustomDialogType.success => 'تم',
      CustomDialogType.delete => 'حذف',
      CustomDialogType.notice => 'فهمت',
    };
  }

  bool get _resolvedShowSecondary {
    if (showSecondaryButton != null) return showSecondaryButton!;

    return type == CustomDialogType.confirm || type == CustomDialogType.delete;
  }

  bool get _isDestructive => type == CustomDialogType.delete;

  Color get _resolvedPrimaryBackground {
    if (primaryButtonColor != null) return primaryButtonColor!;

    return _isDestructive ? ColorPalette.error : ColorPalette.accent;
  }

  Color get _resolvedPrimaryForeground {
    if (primaryButtonTextColor != null) return primaryButtonTextColor!;

    return _isDestructive ? ColorPalette.textLight : ColorPalette.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight =
        MediaQuery.sizeOf(context).height * maxHeightFactor;

    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      backgroundColor: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
            decoration: BoxDecoration(
              color: ColorPalette.fieldFill,
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(color: ColorPalette.fieldBorder, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  blurRadius: 30.r,
                  offset: Offset(0, 12.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DialogHeader(
                  title: title,
                  subtitle: subtitle,
                  showCloseButton: showCloseButton,
                  onClose: onClose ?? () => Navigator.of(context).pop(),
                ),
                if (message != null || body != null) ...[
                  verticalSpace(16),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (message != null)
                            Text(
                              message!,
                              textAlign: TextAlign.center,
                              style:
                                  AppTextStyle.font14TextMutedRegularTajawal(),
                            ),
                          ?body,
                        ],
                      ),
                    ),
                  ),
                ],
                if (showPrimaryButton) ...[
                  verticalSpace(20),
                  CustomButton(
                    text: _resolvedPrimaryText,
                    onPressed:
                        onPrimaryPressed ?? () => Navigator.of(context).pop(),
                    height: 50.h,
                    background: _resolvedPrimaryBackground,
                    foreground: _resolvedPrimaryForeground,
                    borderRadius: 24.r,
                    textStyle: AppTextStyle.font15TextPrimaryBoldTajawal()
                        .copyWith(color: _resolvedPrimaryForeground),
                  ),
                ],
                if (_resolvedShowSecondary) ...[
                  verticalSpace(10),
                  CustomSecondaryButton(
                    text: secondaryButtonText,
                    onPressed:
                        onSecondaryPressed ?? () => Navigator.of(context).pop(),
                    height: 50.h,
                    backgroundColor: Colors.transparent,
                    borderColor: ColorPalette.fieldBorder,
                    borderWidth: 1,
                    borderRadius: 24.r,
                    foregroundColor: ColorPalette.textLight,
                    textStyle: AppTextStyle.font15TextLightBoldTajawal(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({
    required this.title,
    required this.subtitle,
    required this.showCloseButton,
    required this.onClose,
  });

  final String title;
  final String? subtitle;
  final bool showCloseButton;
  final VoidCallback onClose;

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
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.font18TextLightBoldTajawal(),
              ),
              if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                verticalSpace(2),
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font12TextMutedRegularTajawal(),
                ),
              ],
            ],
          ),
        ),
        if (showCloseButton) ...[
          horizontalSpace(12),
          Semantics(
            button: true,
            label: 'إغلاق',
            child: Material(
              color: ColorPalette.panelGlass,
              borderRadius: BorderRadius.circular(14.r),
              child: InkWell(
                onTap: onClose,
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: ColorPalette.fieldBorder,
                      width: 1.w,
                    ),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.r,
                    color: ColorPalette.teal200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
