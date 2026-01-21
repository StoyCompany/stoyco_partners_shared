import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

enum ValidationState { idle, validating, success, error }

// Phone number validator input using pinput package
class PhoneValidatorInput extends StatefulWidget {
  const PhoneValidatorInput({
    super.key,
    this.onTimerExpired,
    this.onChanged,
    this.onCompleted,
  });

  final VoidCallback? onTimerExpired;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<PhoneValidatorInput> createState() => PhoneValidatorInputState();
}

class PhoneValidatorInputState extends State<PhoneValidatorInput> {
  late final TextEditingController _pinController;
  late final FocusNode focusNode;

  Timer? _timer;
  int _remainingSeconds =
      20; // 5 minutes (change from 10 to 300 for production)
  bool _isTimerActive = true;
  ValidationState _validationState = ValidationState.idle;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    focusNode = FocusNode();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _isTimerActive = true;
    _remainingSeconds = 20; // 5 minutes (change from 10 to 300 for production)

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isTimerActive = false;
          _timer?.cancel();
          widget.onTimerExpired?.call();
        }
      });
    });
  }

  /// Call this method from parent to restart the timer after resending code
  void restartTimer() {
    _pinController.clear();
    _errorMessage = null;
    _validationState = ValidationState.idle;
    _startTimer();
    setState(() {});
  }

  /// Get the current pin value
  String get pin => _pinController.text;

  /// Check if timer is still active
  bool get isTimerActive => _isTimerActive;

  /// Clear the pin input
  void clearPin() {
    _pinController.clear();
  }

  /// Set validation state to loading (called by controller when validating)
  void setValidating() {
    setState(() {
      _validationState = ValidationState.validating;
    });
  }

  /// Set validation state to success (called by controller when code is correct)
  void setSuccess() {
    _timer?.cancel();
    setState(() {
      _validationState = ValidationState.success;
      _errorMessage = null;
    });
  }

  /// Set validation state to error (called by controller when code is incorrect)
  void setError(String errorMessage) {
    setState(() {
      _validationState = ValidationState.error;
      _errorMessage = errorMessage;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Color _getTextColor() {
    switch (_validationState) {
      case ValidationState.success:
        return ColorFoundation.text.saSuccess;
      case ValidationState.error:
        return ColorFoundation.text.saError;
      default:
        return ColorFoundation.text.saHighlights;
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = ColorFoundation.border.saHighlights;

    final defaultPinTheme = PinTheme(
      height: 58,
      width: 47,
      textStyle: FontFoundation.label.akkuratRegularSaHighlights.copyWith(
        fontSize: 40,
        color: _getTextColor(),
      ),
      decoration: BoxDecoration(
        color: ColorFoundation.background.saLight,
        border: Border.all(color: ColorFoundation.border.saHighlights),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Padding(
      padding: StoycoScreenSize.symmetric(context, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Pinput(
            length: 6,
            controller: _pinController,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) {
              return Gutter(10);
            },
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onChanged: (pin) {
              // Clear error state when user starts typing again
              if (_validationState == ValidationState.error) {
                setState(() {
                  _validationState = ValidationState.idle;
                  _errorMessage = null;
                });
              }
              widget.onChanged?.call(pin);
            },
            onCompleted: (pin) {
              widget.onCompleted?.call(pin);
            },
            enabled:
                _validationState != ValidationState.validating &&
                _validationState != ValidationState.success,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: focusedBorderColor),
                boxShadow: [
                  BoxShadow(
                    color: ColorFoundation.shadow.saHighlights,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Gutter(15),
          // Show timer, error message, or success message
          if (_validationState != ValidationState.validating)
            _buildStatusRow()
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    // Success state
    if (_validationState == ValidationState.success) {
      return Row(
        children: [
          Expanded(
            child: Text(
              '¡Código verificado!',
              style: FontFoundation.label.semiBold14saError.copyWith(
                color: ColorFoundation.text.saSuccess,
              ),
            ),
          ),
        ],
      );
    }

    // Timer expired
    if (!_isTimerActive) {
      return Row(
        children: [
          Text(
            _formatTime(_remainingSeconds),
            style: FontFoundation.paragraph.semiBold14SaHighlights.copyWith(
              color: ColorFoundation.text.saError,
            ),
          ),
          Gutter(4),
          Expanded(
            child: Text(
              'Tu tiempo ha terminado y tu código ha vencido.',
              style: FontFoundation.label.semiBold14saError,
            ),
          ),
        ],
      );
    }

    // Error state
    if (_validationState == ValidationState.error && _errorMessage != null) {
      return Row(
        children: [
          Text(
            _formatTime(_remainingSeconds),
            style: FontFoundation.paragraph.semiBold14SaHighlights,
          ),
          Gutter(4),
          Expanded(
            child: Text(
              _errorMessage!,
              style: FontFoundation.label.semiBold14saError,
            ),
          ),
        ],
      );
    }

    // Default: just show timer
    return Row(
      children: [
        Text(
          _formatTime(_remainingSeconds),
          style: FontFoundation.paragraph.semiBold14SaHighlights,
        ),
      ],
    );
  }
}
