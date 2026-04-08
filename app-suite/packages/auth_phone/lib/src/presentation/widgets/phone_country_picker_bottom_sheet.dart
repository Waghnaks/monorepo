import 'package:auth_phone/src/domain/models/phone_country.dart';
import 'package:auth_phone/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:auth_phone/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:auth_phone/src/presentation/widgets/phone_country_flag.dart';
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

    return Column(
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
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: resolvedTheme.surfaceMutedColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 15,
                    color: resolvedTheme.mutedForegroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: resolvedTheme.surfaceMutedColor,
              borderRadius: BorderRadius.circular(12),
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
                    style: resolvedTheme.inputTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: PhoneAuthCopyDefaults.countryPickerSearchHint,
                      hintStyle: resolvedTheme.inputHintTextStyle.copyWith(
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
              : ListView.builder(
                  itemCount: _filteredCountries.length,
                  itemBuilder: (_, index) {
                    final country = _filteredCountries[index];
                    final isSelected =
                        country.isoCode == widget.selectedCountry.isoCode;

                    return InkWell(
                      onTap: () {
                        widget.onSelect(country);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.themeColor.withValues(alpha: 0.08)
                              : Colors.transparent,
                          border: Border(
                            left: BorderSide(
                              color: isSelected
                                  ? widget.themeColor
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 13,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: PhoneCountryFlag(
                                country: country,
                                size: 34,
                                backgroundColor: isSelected
                                    ? widget.themeColor.withValues(alpha: 0.12)
                                    : resolvedTheme.surfaceMutedColor,
                                foregroundColor: isSelected
                                    ? widget.themeColor
                                    : resolvedTheme.mutedForegroundColor,
                                borderRadius: 10,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                country.name,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? widget.themeColor
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      widget.themeColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  'Selected',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: widget.themeColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                            Text(
                              country.dialCode,
                              style: TextStyle(
                                fontSize: 13,
                                color: isSelected
                                    ? widget.themeColor
                                    : resolvedTheme.mutedForegroundColor,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
      ],
    );
  }
}
