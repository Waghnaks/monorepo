import 'package:phone_auth/src/domain/models/phone_country.dart';
import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneCountryFlag extends StatelessWidget {
  const PhoneCountryFlag({
    required this.country,
    super.key,
    this.size = 24,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  final PhoneCountry country;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackgroundColor =
        backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final resolvedForegroundColor =
        foregroundColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.72);
    final resolvedBorderRadius = borderRadius ?? (size * 0.34);

    if (country.isoCode == IsoCode.IN) {
      return _IndiaFlagBadge(
        size: size,
        borderRadius: resolvedBorderRadius,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: resolvedBackgroundColor,
              borderRadius: BorderRadius.circular(resolvedBorderRadius),
            ),
            alignment: Alignment.center,
            child: Text(
              country.isoCode.name,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w700,
                color: resolvedForegroundColor,
                letterSpacing: 0.25,
                height: 1,
              ),
            ),
          ),
          Text(
            country.flag,
            style: TextStyle(
              fontSize: size * 0.76,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _IndiaFlagBadge extends StatelessWidget {
  const _IndiaFlagBadge({
    required this.size,
    required this.borderRadius,
  });

  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final stripeHeight = size / 3;
    final chakraSize = size * 0.22;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: stripeHeight,
                  color: const Color(0xFFFF9933),
                ),
                Expanded(
                  child: Container(color: Colors.white),
                ),
                Container(
                  height: stripeHeight,
                  color: const Color(0xFF138808),
                ),
              ],
            ),
            Container(
              width: chakraSize,
              height: chakraSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF000080),
                  width: size * 0.04,
                ),
              ),
            ),
            Container(
              width: size * 0.04,
              height: chakraSize,
              color: const Color(0xFF000080).withValues(alpha: 0.9),
            ),
            Container(
              width: chakraSize,
              height: size * 0.04,
              color: const Color(0xFF000080).withValues(alpha: 0.9),
            ),
          ],
        ),
      ),
    );
  }
}
