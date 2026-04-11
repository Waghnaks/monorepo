import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpCodeInputField extends StatefulWidget {
  const OtpCodeInputField({
    required this.length,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.themeColor,
    this.hasError = false,
    this.onCompleted,
  });

  final int length;
  final bool enabled;
  final Color? themeColor;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpCodeInputField> createState() => _OtpCodeInputFieldState();
}

class _OtpCodeInputFieldState extends State<OtpCodeInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List<FocusNode>.generate(widget.length, (_) => FocusNode());
    for (final focusNode in _focusNodes) {
      focusNode.addListener(_handleFocusChanged);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.removeListener(_handleFocusChanged);
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleChanged(int index, String value) {
    final sanitized = value.replaceAll(RegExp(r'\D'), '');
    final normalized =
        sanitized.isEmpty ? '' : sanitized.substring(sanitized.length - 1);

    if (_controllers[index].text != normalized) {
      _controllers[index].value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
    }

    if (normalized.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (normalized.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _controllers.map((controller) => controller.text).join();
    widget.onChanged(code);

    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
      _focusNodes.last.unfocus();
    }

    setState(() {});
  }

  Color _resolveBorderColor(int index) {
    if (widget.hasError) {
      return const Color(0xFFE24B4A);
    }

    if (_focusNodes[index].hasFocus) {
      return widget.themeColor ?? Colors.black;
    }

    if (_controllers[index].text.isNotEmpty) {
      return widget.themeColor?.withValues(alpha: 0.65) ??
          const Color(0xFF6B6560);
    }

    return const Color(0xFFE2DDD8);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor =
        widget.themeColor ?? Theme.of(context).colorScheme.primary;

    return Row(
      children: List<Widget>.generate(widget.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == widget.length - 1 ? 0 : 8),
            child: SizedBox(
              height: 58,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                enabled: widget.enabled,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textInputAction: index == widget.length - 1
                    ? TextInputAction.done
                    : TextInputAction.next,
                maxLength: 1,
                cursorColor: themeColor,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1917),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) => _handleChanged(index, value),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor:
                      widget.enabled ? Colors.white : const Color(0xFFF5F4F2),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _resolveBorderColor(index),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _resolveBorderColor(index),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _resolveBorderColor(index),
                      width: 1.8,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFFE9E3DC),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
