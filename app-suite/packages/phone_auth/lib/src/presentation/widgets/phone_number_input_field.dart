import 'package:phone_auth/src/data/services/phone_number_hint_service.dart';
import 'package:phone_auth/src/domain/models/phone_country.dart';
import 'package:phone_auth/src/domain/models/phone_number_result.dart';
import 'package:phone_auth/src/domain/validation/phone_number_validator.dart';
import 'package:phone_auth/src/foundation/copy/phone_auth_copy_defaults.dart';
import 'package:phone_auth/src/foundation/platform/phone_auth_platform_defaults.dart';
import 'package:phone_auth/src/presentation/controllers/phone_number_input_controller.dart';
import 'package:phone_auth/src/presentation/models/phone_number_hint_value.dart';
import 'package:phone_auth/src/presentation/theme/phone_auth_resolved_theme.dart';
import 'package:phone_auth/src/presentation/utils/phone_number_hint_parser.dart';
import 'package:phone_auth/src/presentation/widgets/phone_country_flag.dart';
import 'package:phone_auth/src/presentation/widgets/phone_country_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneNumberInputField extends StatefulWidget {
  const PhoneNumberInputField({
    required this.controller,
    super.key,
    this.initialCountry = IsoCode.IN,
    this.label,
    this.hintText = PhoneAuthCopyDefaults.phoneFieldFallbackHintText,
    this.enabled = true,
    this.showCountryPicker = true,
    this.themeColor,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  final PhoneNumberInputController controller;
  final IsoCode initialCountry;
  final String? label;
  final String hintText;
  final bool enabled;
  final bool showCountryPicker;
  final Color? themeColor;
  final void Function(PhoneNumberResult result)? onChanged;
  final void Function(PhoneNumberResult result)? onSubmitted;
  final String? Function(PhoneNumberResult? result)? validator;

  @override
  State<PhoneNumberInputField> createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late PhoneCountry _selectedCountry;
  PhoneNumberResult? _lastResult;
  late PhoneNumberInputController _publicController;
  bool _hasRequestedPhoneNumberHint = false;
  bool _isRequestingPhoneNumberHint = false;

  @override
  void initState() {
    super.initState();
    _publicController = widget.controller;
    _publicController.bindClearHandler(_clearField);
    _publicController.bindUnfocusHandler(_unfocusField);
    final initialValue = _publicController.value;
    _selectedCountry = initialValue != null
        ? phoneCountryByIso(initialValue.isoCode)
        : phoneCountryByIso(widget.initialCountry);
    _lastResult = initialValue;
    _textController.text = initialValue?.nationalNumber ?? '';
    _hasRequestedPhoneNumberHint = _textController.text.trim().isNotEmpty;
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final raw = _textController.text.trim();

    if (raw.isEmpty) {
      _lastResult = null;
      _publicController.updateValue(null);
      widget.onChanged?.call(
        PhoneNumberResult(
          nationalNumber: '',
          dialCode: _selectedCountry.dialCode,
          isoCode: _selectedCountry.isoCode,
          isValid: false,
          isComplete: false,
        ),
      );
      return;
    }

    final validation = PhoneNumberValidator.validate(
      country: _selectedCountry,
      nationalNumber: raw,
    );

    final result = PhoneNumberResult(
      nationalNumber: raw,
      dialCode: _selectedCountry.dialCode,
      isoCode: _selectedCountry.isoCode,
      isValid: validation.isValid,
      isComplete: validation.isComplete,
      validationMessage: validation.hasVisibleError
          ? PhoneAuthCopyDefaults.phoneNumberValidationMessage(
              countryName: _selectedCountry.name,
              failure: validation.failure!,
            )
          : null,
    );

    _lastResult = result;
    _publicController.updateValue(result);
    widget.onChanged?.call(result);
  }

  void _clearField() {
    if (!widget.enabled) {
      return;
    }

    _textController.clear();
    setState(() {});
  }

  void _unfocusField() {
    _focusNode.unfocus();
  }

  Future<void> _requestPhoneNumberHintOnFirstTap() async {
    if (_hasRequestedPhoneNumberHint ||
        _isRequestingPhoneNumberHint ||
        !widget.enabled ||
        _textController.text.trim().isNotEmpty) {
      return;
    }

    _hasRequestedPhoneNumberHint = true;
    _isRequestingPhoneNumberHint = true;

    _focusNode.unfocus();
    await SystemChannels.textInput.invokeMethod<void>(
      PhoneAuthPlatformDefaults.hideTextInputMethod,
    );

    final hintedPhoneNumber =
        await PhoneNumberHintService.requestPhoneNumberHint();

    if (!mounted) {
      return;
    }

    _isRequestingPhoneNumberHint = false;

    if (hintedPhoneNumber == null) {
      _focusNode.requestFocus();
      return;
    }

    _applyPhoneNumberHint(hintedPhoneNumber);
  }

  void _applyPhoneNumberHint(String hintedPhoneNumber) {
    final hintValue = resolvePhoneNumberHint(
      hintedPhoneNumber,
      fallbackCountry: _selectedCountry,
    );

    if (hintValue == null) {
      _focusNode.requestFocus();
      return;
    }

    _updateFieldFromHint(hintValue);
  }

  void _updateFieldFromHint(PhoneNumberHintValue hintValue) {
    setState(() {
      _selectedCountry = hintValue.country;
      _textController.value = TextEditingValue(
        text: hintValue.nationalNumber,
        selection: TextSelection.collapsed(
          offset: hintValue.nationalNumber.length,
        ),
      );
    });
  }

  void _openCountryPicker() {
    if (!widget.enabled || !widget.showCountryPicker) {
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.78,
      ),
      builder: (_) => PhoneCountryPickerBottomSheet(
        selectedCountry: _selectedCountry,
        themeColor: PhoneAuthResolvedTheme.of(
          context,
          accentColor: widget.themeColor,
        ).accentColor,
        onSelect: (country) {
          setState(() {
            _selectedCountry = country;
            _textController.clear();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = PhoneAuthResolvedTheme.of(
      context,
      accentColor: widget.themeColor,
    );
    final fieldErrorText =
        widget.validator?.call(_lastResult) ?? _lastResult?.validationMessage;
    final hasFieldError = fieldErrorText != null && fieldErrorText.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: resolvedTheme.fieldLabelTextStyle,
            ),
            const SizedBox(height: 6),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? Theme.of(context).colorScheme.surface
                      : resolvedTheme.surfaceMutedColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: hasFieldError
                        ? resolvedTheme.dangerColor
                        : resolvedTheme.outlineColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap:
                          widget.showCountryPicker ? _openCountryPicker : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PhoneCountryFlag(
                              country: _selectedCountry,
                              size: 24,
                              backgroundColor: resolvedTheme.surfaceMutedColor,
                              foregroundColor:
                                  resolvedTheme.mutedForegroundColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _selectedCountry.dialCode,
                              style: resolvedTheme.valueTextStyle,
                            ),
                            if (widget.showCountryPicker) ...[
                              const SizedBox(width: 3),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 15,
                                color: resolvedTheme.accentColor,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: resolvedTheme.outlineColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: widget.enabled &&
                                !_hasRequestedPhoneNumberHint &&
                                _textController.text.trim().isEmpty
                            ? _requestPhoneNumberHintOnFirstTap
                            : null,
                        child: AbsorbPointer(
                          absorbing: !_hasRequestedPhoneNumberHint &&
                              _textController.text.trim().isEmpty,
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            enabled: widget.enabled,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                            textInputAction: TextInputAction.done,
                            enableSuggestions: false,
                            autocorrect: false,
                            onTapOutside: (_) => _unfocusField(),
                            cursorColor: resolvedTheme.accentColor,
                            cursorWidth: 1.6,
                            cursorRadius: const Radius.circular(2),
                            inputFormatters: [
                              const _DigitsOnlyFormatter(),
                              LengthLimitingTextInputFormatter(
                                _selectedCountry.maxNationalNumberLength,
                              ),
                            ],
                            onSubmitted: (_) {
                              if (_lastResult != null) {
                                widget.onSubmitted?.call(_lastResult!);
                              }
                            },
                            style: resolvedTheme.valueTextStyle,
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: resolvedTheme.fieldHintTextStyle,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 160),
                      child: ValueListenableBuilder<TextEditingValue>(
                        key: const ValueKey('clear'),
                        valueListenable: _textController,
                        builder: (_, value, __) {
                          if (value.text.isEmpty) {
                            return const SizedBox(width: 14);
                          }
                          return GestureDetector(
                            onTap: widget.enabled ? _clearField : null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: resolvedTheme.outlineColor,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 11,
                                  color: resolvedTheme.mutedForegroundColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (hasFieldError) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 12,
                      color: resolvedTheme.dangerColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        fieldErrorText,
                        style: TextStyle(
                          fontSize: 11,
                          color: resolvedTheme.dangerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _DigitsOnlyFormatter extends TextInputFormatter {
  const _DigitsOnlyFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    return newValue.copyWith(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}
