import 'package:phone_auth/src/domain/models/phone_country.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/widgets/phone_country_flag.dart';
import 'package:flutter/material.dart';

class PhoneCountryPickerBottomSheet extends StatefulWidget {
  const PhoneCountryPickerBottomSheet({
    required this.selectedCountry,
    required this.onSelect,
    required this.themeColor,
    super.key,
  });

  final PhoneCountry selectedCountry;
  final ValueChanged<PhoneCountry> onSelect;
  final Color themeColor;

  @override
  State<PhoneCountryPickerBottomSheet> createState() =>
      _PhoneCountryPickerBottomSheetState();
}

class _PhoneCountryPickerBottomSheetState
    extends State<PhoneCountryPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<PhoneCountry> _filteredCountries = kPhoneCountries;

  void _filterCountries(String query) {
    setState(() {
      _filteredCountries = searchPhoneCountries(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: widget.themeColor,
    );
    final colorScheme = Theme.of(context).colorScheme;
    final searchFieldColor = resolvedTheme.surfaceMutedColor.withValues(
      alpha: 0.6,
    );
    final selectedRowColor = widget.themeColor.withValues(alpha: 0.055);

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 10),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: resolvedTheme.outlineColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    PhoneAuthCopyDefaults.countryPickerTitle,
                    style: resolvedTheme.headingTextStyle.copyWith(
                      fontSize: 16,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: resolvedTheme.mutedForegroundColor,
                    ),
                    icon: const Icon(Icons.close_rounded, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: searchFieldColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: resolvedTheme.outlineColor.withValues(alpha: 0.7),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      Icons.search_rounded,
                      size: 17,
                      color: resolvedTheme.mutedForegroundColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterCountries,
                        style: resolvedTheme.valueTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              PhoneAuthCopyDefaults.countryPickerSearchHint,
                          hintStyle: resolvedTheme.fieldHintTextStyle.copyWith(
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Divider(height: 1, color: resolvedTheme.outlineColor),
            Flexible(
              child: _filteredCountries.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        PhoneAuthCopyDefaults.countryPickerEmptyState,
                        style: resolvedTheme.supportingTextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                      itemCount: _filteredCountries.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (_, index) {
                        final country = _filteredCountries[index];
                        final isSelected =
                            country.isoCode == widget.selectedCountry.isoCode;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              widget.onSelect(country);
                              Navigator.of(context).pop();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? selectedRowColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  PhoneCountryFlag(
                                    country: country,
                                    size: 32,
                                    backgroundColor: isSelected
                                        ? widget.themeColor.withValues(
                                            alpha: 0.12,
                                          )
                                        : resolvedTheme.surfaceMutedColor,
                                    foregroundColor: isSelected
                                        ? widget.themeColor
                                        : resolvedTheme.mutedForegroundColor,
                                    borderRadius: 10,
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      country.name,
                                      style:
                                          resolvedTheme.valueTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    country.dialCode,
                                    style:
                                        resolvedTheme.actionTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: resolvedTheme.mutedForegroundColor,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 10),
                                    _SelectedCountryIndicator(
                                      accentColor: widget.themeColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }
}

class _SelectedCountryIndicator extends StatelessWidget {
  const _SelectedCountryIndicator({
    required this.accentColor,
  });

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor.withValues(alpha: 0.12),
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
