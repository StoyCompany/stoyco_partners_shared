import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

// Phone number validator input using pinput package
class PhoneValidatorInput extends StatefulWidget {
  const PhoneValidatorInput({super.key});

  @override
  State<PhoneValidatorInput> createState() => _PhoneValidatorInputState();
}

class _PhoneValidatorInputState extends State<PhoneValidatorInput> {
  late final TextEditingController _pinController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = ColorFoundation.border.saHighlights;

    final defaultPinTheme = PinTheme(
      height: 58,
      width: 47,
      decoration: BoxDecoration(
        color: ColorFoundation.background.saLight,
        border: Border.all(color: ColorFoundation.border.saHighlights),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Pinput(
      length: 6,
      controller: _pinController,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (index) {
        return Gutter(10);
      },
      validator: (value) {
        return value == "2222" ? null : 'Código inválido';
      },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
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
    );
  }
}
