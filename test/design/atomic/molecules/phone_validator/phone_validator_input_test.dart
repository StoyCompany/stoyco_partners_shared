import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/phone_validator/phone_validator_input.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('PhoneValidatorInput', () {
    testWidgets('renders with basic configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      expect(find.byType(PhoneValidatorInput), findsOneWidget);
      expect(find.byType(Pinput), findsOneWidget);
    });

    testWidgets('displays 6 pin input fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.length, 6);
    });

    testWidgets('displays initial timer at 5:00', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      expect(find.text('05:00'), findsOneWidget);
    });

    testWidgets('timer counts down every second', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      // Initial time
      expect(find.text('05:00'), findsOneWidget);

      // Wait 1 second
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('04:59'), findsOneWidget);

      // Wait another second
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('04:58'), findsOneWidget);
    });

    testWidgets('accepts pin input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      // Enter pin
      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.controller?.text, '123456');
    });

    testWidgets('calls onChanged callback when pin changes', (
      WidgetTester tester,
    ) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhoneValidatorInput(
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(Pinput), '12');
      await tester.pump();

      expect(changedValue, '12');
    });

    testWidgets('calls onCompleted callback when pin is complete', (
      WidgetTester tester,
    ) async {
      String? completedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhoneValidatorInput(
              onCompleted: (value) {
                completedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();

      expect(completedValue, '123456');
    });

    testWidgets('calls onTimerExpired when timer reaches zero', (
      WidgetTester tester,
    ) async {
      bool timerExpired = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhoneValidatorInput(
              onTimerExpired: () {
                timerExpired = true;
              },
            ),
          ),
        ),
      );

      // Fast forward past the timer (300 seconds = 5 minutes)
      await tester.pump(const Duration(seconds: 301));

      expect(timerExpired, true);
    });

    testWidgets('displays expired message when timer reaches zero', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      // Fast forward past the timer
      await tester.pump(const Duration(seconds: 301));

      expect(
        find.text('Tu tiempo ha terminado y tu código ha vencido.'),
        findsOneWidget,
      );
    });

    testWidgets('restartTimer method resets timer to 5:00', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Wait some time
      await tester.pump(const Duration(seconds: 30));
      expect(find.text('04:30'), findsOneWidget);

      // Restart timer
      key.currentState!.restartTimer();
      await tester.pump();

      expect(find.text('05:00'), findsOneWidget);
    });

    testWidgets('restartTimer clears pin input', (WidgetTester tester) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Enter pin
      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();

      // Restart timer
      key.currentState!.restartTimer();
      await tester.pump();

      expect(key.currentState!.pin, '');
    });

    testWidgets('clearPin method clears the input', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Enter pin
      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();
      expect(key.currentState!.pin, '123456');

      // Clear pin
      key.currentState!.clearPin();
      await tester.pump();

      expect(key.currentState!.pin, '');
    });

    testWidgets('setValidating disables input', (WidgetTester tester) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set validating state
      key.currentState!.setValidating();
      await tester.pump();

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.enabled, false);
    });

    testWidgets('setSuccess shows success message', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set success state
      key.currentState!.setSuccess();
      await tester.pump();

      expect(find.text('¡Código verificado!'), findsOneWidget);
    });

    testWidgets('setSuccess stops timer', (WidgetTester tester) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set success state
      key.currentState!.setSuccess();
      await tester.pump();

      final currentTime = find.text('¡Código verificado!');
      expect(currentTime, findsOneWidget);

      // Timer should not continue
      await tester.pump(const Duration(seconds: 2));
      expect(currentTime, findsOneWidget);
      expect(find.text('04:58'), findsNothing);
    });

    testWidgets('setSuccess disables input', (WidgetTester tester) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set success state
      key.currentState!.setSuccess();
      await tester.pump();

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.enabled, false);
    });

    testWidgets('setError shows error message', (WidgetTester tester) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set error state
      key.currentState!.setError('Código incorrecto');
      await tester.pump();

      expect(find.text('Código incorrecto'), findsOneWidget);
    });

    testWidgets('error state clears when user types again', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set error state
      key.currentState!.setError('Código incorrecto');
      await tester.pump();
      expect(find.text('Código incorrecto'), findsOneWidget);

      // User types
      await tester.enterText(find.byType(Pinput), '1');
      await tester.pump();

      // Error should be cleared
      expect(find.text('Código incorrecto'), findsNothing);
    });

    testWidgets('isTimerActive returns correct state', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Initially active
      expect(key.currentState!.isTimerActive, true);

      // After timer expires
      await tester.pump(const Duration(seconds: 301));
      expect(key.currentState!.isTimerActive, false);
    });

    testWidgets('pin getter returns current pin value', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      expect(key.currentState!.pin, '');

      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();

      expect(key.currentState!.pin, '123456');
    });

    testWidgets('displays success text color when in success state', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Enter text and set success
      await tester.enterText(find.byType(Pinput), '123456');
      key.currentState!.setSuccess();
      await tester.pump();

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(
        pinput.defaultPinTheme?.textStyle?.color,
        ColorFoundation.text.saSuccess,
      );
    });

    testWidgets('displays error text color when in error state', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set error
      key.currentState!.setError('Error message');
      await tester.pump();

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(
        pinput.defaultPinTheme?.textStyle?.color,
        ColorFoundation.text.saError,
      );
    });

    testWidgets('timer format shows correct minutes and seconds', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      // Initial: 5 minutes
      expect(find.text('05:00'), findsOneWidget);

      // After 1 minute
      await tester.pump(const Duration(seconds: 60));
      expect(find.text('04:00'), findsOneWidget);

      // After 4 minutes 30 seconds
      await tester.pump(const Duration(seconds: 210));
      expect(find.text('00:30'), findsOneWidget);

      // After 4 minutes 59 seconds
      await tester.pump(const Duration(seconds: 29));
      expect(find.text('00:01'), findsOneWidget);

      // After 5 minutes
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('00:00'), findsOneWidget);
    });

    testWidgets('restartTimer resets validation state to idle', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // Set error state
      key.currentState!.setError('Error message');
      await tester.pump();
      expect(find.text('Error message'), findsOneWidget);

      // Restart timer
      key.currentState!.restartTimer();
      await tester.pump();

      // Error should be cleared
      expect(find.text('Error message'), findsNothing);
    });

    testWidgets('expired timer shows red timer color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      // Fast forward past the timer
      await tester.pump(const Duration(seconds: 301));

      // Find the timer text widget
      final timerText = tester.widget<Text>(find.text('00:00'));

      // Should have error color
      expect(timerText.style?.color, ColorFoundation.text.saError);
    });

    testWidgets('input has haptic feedback enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PhoneValidatorInput())),
      );

      final pinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(pinput.hapticFeedbackType, HapticFeedbackType.lightImpact);
    });

    testWidgets('multiple calls to setError update message', (
      WidgetTester tester,
    ) async {
      final key = GlobalKey<PhoneValidatorInputState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PhoneValidatorInput(key: key)),
        ),
      );

      // First error
      key.currentState!.setError('First error');
      await tester.pump();
      expect(find.text('First error'), findsOneWidget);

      // Second error
      key.currentState!.setError('Second error');
      await tester.pump();
      expect(find.text('First error'), findsNothing);
      expect(find.text('Second error'), findsOneWidget);
    });
  });
}
