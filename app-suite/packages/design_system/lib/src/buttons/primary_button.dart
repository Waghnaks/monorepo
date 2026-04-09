import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.title = 'Continue',
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 20,
    this.minHeight = 56,
    this.expand = true,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final double minHeight;
  final bool expand;

  bool get _usesDisabledStyle => isDisabled || isLoading || onPressed == null;

  bool get _blocksInteraction => isDisabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;
    final resolvedForegroundColor =
        foregroundColor ?? theme.colorScheme.onPrimary;

    final disabledBackgroundColor =
        resolvedBackgroundColor.withValues(alpha: 0.38);
    final disabledForegroundColor =
        resolvedForegroundColor.withValues(alpha: 0.38);
    final effectiveBackgroundColor =
        _usesDisabledStyle ? disabledBackgroundColor : resolvedBackgroundColor;
    final effectiveForegroundColor =
        _usesDisabledStyle ? disabledForegroundColor : resolvedForegroundColor;

    final buttonChild = DefaultTextStyle(
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: effectiveForegroundColor,
      ),
      child: Center(
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveForegroundColor,
                  ),
                ),
              )
            : Text(title.toUpperCase()),
      ),
    );

    final button = Semantics(
      button: true,
      enabled: !_blocksInteraction,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: _blocksInteraction ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            height: minHeight,
            child: buttonChild,
          ),
        ),
      ),
    );

    if (!expand) return button;

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
