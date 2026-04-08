import 'package:flutter/cupertino.dart';
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

  /// A button is effectively disabled when [isDisabled] is true
  /// OR when no [onPressed] callback is provided.
  bool get _isEffectivelyDisabled =>
      isDisabled || isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;
    final resolvedForegroundColor =
        foregroundColor ?? theme.colorScheme.onPrimary;

    // Industry standard: disabled state uses 38% opacity on color (Material 3 spec)
    final disabledBackgroundColor =
        resolvedBackgroundColor.withValues(alpha: 0.38);
    final disabledForegroundColor =
        resolvedForegroundColor.withValues(alpha: 0.38);

    final button = SizedBox(
      height: minHeight,
      child: ElevatedButton(
        // Pass null to onPressed to let Flutter handle the disabled state natively
        onPressed: _isEffectivelyDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBackgroundColor,
          foregroundColor: resolvedForegroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          elevation: 0,
          // Disabled buttons should have no shadow
          shadowColor: _isEffectivelyDisabled ? Colors.transparent : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 18,
                  width: 18,
                  child: CupertinoActivityIndicator(
                    color: resolvedForegroundColor,
                    radius: 9,
                  ),
                )
              : Text(
                  title.toUpperCase(),
                  key: const ValueKey('title'),
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
