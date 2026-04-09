import 'package:flutter/material.dart';

@immutable
class PhoneAuthThemeExtension extends ThemeExtension<PhoneAuthThemeExtension> {
  const PhoneAuthThemeExtension({
    this.brandTextStyle,
    this.tagLineTextStyle,
    this.headingTextStyle,
    this.supportingTextStyle,
    this.actionTextStyle,
    this.valueTextStyle,
    this.fieldLabelTextStyle,
    this.fieldHintTextStyle,
    this.legalTextStyle,
    this.legalLinkTextStyle,
    this.documentTitleTextStyle,
    this.accentTitleTextStyle,
    this.surfaceMutedColor,
    this.outlineColor,
    this.mutedForegroundColor,
    this.dangerColor,
    this.documentBackgroundColor,
    this.documentViewerBackgroundColor,
    this.documentLoaderColor,
  });

  final TextStyle? brandTextStyle;
  final TextStyle? tagLineTextStyle;
  final TextStyle? headingTextStyle;
  final TextStyle? supportingTextStyle;
  final TextStyle? actionTextStyle;
  final TextStyle? valueTextStyle;
  final TextStyle? fieldLabelTextStyle;
  final TextStyle? fieldHintTextStyle;
  final TextStyle? legalTextStyle;
  final TextStyle? legalLinkTextStyle;
  final TextStyle? documentTitleTextStyle;
  final TextStyle? accentTitleTextStyle;
  final Color? surfaceMutedColor;
  final Color? outlineColor;
  final Color? mutedForegroundColor;
  final Color? dangerColor;
  final Color? documentBackgroundColor;
  final Color? documentViewerBackgroundColor;
  final Color? documentLoaderColor;

  @override
  PhoneAuthThemeExtension copyWith({
    TextStyle? brandTextStyle,
    TextStyle? tagLineTextStyle,
    TextStyle? headingTextStyle,
    TextStyle? supportingTextStyle,
    TextStyle? actionTextStyle,
    TextStyle? valueTextStyle,
    TextStyle? fieldLabelTextStyle,
    TextStyle? fieldHintTextStyle,
    TextStyle? legalTextStyle,
    TextStyle? legalLinkTextStyle,
    TextStyle? documentTitleTextStyle,
    TextStyle? accentTitleTextStyle,
    Color? surfaceMutedColor,
    Color? outlineColor,
    Color? mutedForegroundColor,
    Color? dangerColor,
    Color? documentBackgroundColor,
    Color? documentViewerBackgroundColor,
    Color? documentLoaderColor,
  }) {
    return PhoneAuthThemeExtension(
      brandTextStyle: brandTextStyle ?? this.brandTextStyle,
      tagLineTextStyle: tagLineTextStyle ?? this.tagLineTextStyle,
      headingTextStyle: headingTextStyle ?? this.headingTextStyle,
      supportingTextStyle: supportingTextStyle ?? this.supportingTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      fieldLabelTextStyle: fieldLabelTextStyle ?? this.fieldLabelTextStyle,
      fieldHintTextStyle: fieldHintTextStyle ?? this.fieldHintTextStyle,
      legalTextStyle: legalTextStyle ?? this.legalTextStyle,
      legalLinkTextStyle: legalLinkTextStyle ?? this.legalLinkTextStyle,
      documentTitleTextStyle:
          documentTitleTextStyle ?? this.documentTitleTextStyle,
      accentTitleTextStyle: accentTitleTextStyle ?? this.accentTitleTextStyle,
      surfaceMutedColor: surfaceMutedColor ?? this.surfaceMutedColor,
      outlineColor: outlineColor ?? this.outlineColor,
      mutedForegroundColor: mutedForegroundColor ?? this.mutedForegroundColor,
      dangerColor: dangerColor ?? this.dangerColor,
      documentBackgroundColor:
          documentBackgroundColor ?? this.documentBackgroundColor,
      documentViewerBackgroundColor:
          documentViewerBackgroundColor ?? this.documentViewerBackgroundColor,
      documentLoaderColor: documentLoaderColor ?? this.documentLoaderColor,
    );
  }

  @override
  PhoneAuthThemeExtension lerp(
    ThemeExtension<PhoneAuthThemeExtension>? other,
    double t,
  ) {
    if (other is! PhoneAuthThemeExtension) {
      return this;
    }

    return PhoneAuthThemeExtension(
      brandTextStyle: TextStyle.lerp(brandTextStyle, other.brandTextStyle, t),
      tagLineTextStyle:
          TextStyle.lerp(tagLineTextStyle, other.tagLineTextStyle, t),
      headingTextStyle:
          TextStyle.lerp(headingTextStyle, other.headingTextStyle, t),
      supportingTextStyle:
          TextStyle.lerp(supportingTextStyle, other.supportingTextStyle, t),
      actionTextStyle:
          TextStyle.lerp(actionTextStyle, other.actionTextStyle, t),
      valueTextStyle: TextStyle.lerp(valueTextStyle, other.valueTextStyle, t),
      fieldLabelTextStyle: TextStyle.lerp(
        fieldLabelTextStyle,
        other.fieldLabelTextStyle,
        t,
      ),
      fieldHintTextStyle: TextStyle.lerp(
        fieldHintTextStyle,
        other.fieldHintTextStyle,
        t,
      ),
      legalTextStyle: TextStyle.lerp(legalTextStyle, other.legalTextStyle, t),
      legalLinkTextStyle:
          TextStyle.lerp(legalLinkTextStyle, other.legalLinkTextStyle, t),
      documentTitleTextStyle: TextStyle.lerp(
        documentTitleTextStyle,
        other.documentTitleTextStyle,
        t,
      ),
      accentTitleTextStyle:
          TextStyle.lerp(accentTitleTextStyle, other.accentTitleTextStyle, t),
      surfaceMutedColor:
          Color.lerp(surfaceMutedColor, other.surfaceMutedColor, t),
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t),
      mutedForegroundColor:
          Color.lerp(mutedForegroundColor, other.mutedForegroundColor, t),
      dangerColor: Color.lerp(dangerColor, other.dangerColor, t),
      documentBackgroundColor:
          Color.lerp(documentBackgroundColor, other.documentBackgroundColor, t),
      documentViewerBackgroundColor: Color.lerp(
        documentViewerBackgroundColor,
        other.documentViewerBackgroundColor,
        t,
      ),
      documentLoaderColor:
          Color.lerp(documentLoaderColor, other.documentLoaderColor, t),
    );
  }
}
