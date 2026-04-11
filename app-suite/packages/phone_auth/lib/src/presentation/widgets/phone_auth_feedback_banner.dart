import 'package:flutter/material.dart';

enum PhoneAuthFeedbackPresentation {
  banner,
  inlineText,
}

class PhoneAuthFeedbackBanner extends StatelessWidget {
  const PhoneAuthFeedbackBanner({
    required this.color,
    required this.message,
    this.presentation = PhoneAuthFeedbackPresentation.banner,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final Color color;
  final String? message;
  final PhoneAuthFeedbackPresentation presentation;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (presentation == PhoneAuthFeedbackPresentation.inlineText) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          message!,
          textAlign: textAlign,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        message!,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
