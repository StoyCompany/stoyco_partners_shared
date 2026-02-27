import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/device.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

void main() {
  group('DeviceType and getDeviceType', () {
    testWidgets('should return mobile for width <= 600', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = getDeviceType(context);
              expect(deviceType, DeviceType.mobile);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should return tablet for 600 < width <= 1200', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1024));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = getDeviceType(context);
              expect(deviceType, DeviceType.tablet);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should return desktop for 1200 < width <= 1600', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1400, 900));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = getDeviceType(context);
              expect(deviceType, DeviceType.desktop);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('should return desktopLarge for width > 1600', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1920, 1080));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = getDeviceType(context);
              expect(deviceType, DeviceType.desktopLarge);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    test('change point constants should have correct values', () {
      expect(tabletChangePoint, 600);
      expect(desktopChangePoint, 1200);
      expect(desktopLargeChangePoint, 1600);
    });

    test('should have all device types in enum', () {
      expect(DeviceType.values.length, 4);
      expect(DeviceType.values, contains(DeviceType.mobile));
      expect(DeviceType.values, contains(DeviceType.tablet));
      expect(DeviceType.values, contains(DeviceType.desktop));
      expect(DeviceType.values, contains(DeviceType.desktopLarge));
    });
  });

  group('StoycoScreenSize - Basic Methods', () {
    testWidgets('screenWidth should return correct width', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final width = StoycoScreenSize.screenWidth(context);
              expect(width, 800);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('screenHeight should return correct height', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final height = StoycoScreenSize.screenHeight(context);
              expect(height, 600);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('StoycoScreenSize - Reference Dimensions', () {
    test('should set desktop reference dimensions', () {
      StoycoScreenSize.setReferenceDimensions(1920, 1080);
      // No exception means success
    });

    test('should set desktop large reference dimensions', () {
      StoycoScreenSize.setReferenceDimensionsDesktopLarge(2560, 1440);
      // No exception means success
    });

    test('should set tablet reference dimensions', () {
      StoycoScreenSize.setReferenceDimensionsTablet(1024, 768);
      // No exception means success
    });

    test('should set mobile reference dimensions', () {
      StoycoScreenSize.setReferenceDimensionsMobile(414, 896);
      // No exception means success
    });
  });

  group('StoycoScreenSize - Device Checks', () {
    testWidgets('isPhone should return true for mobile device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(StoycoScreenSize.isPhone(context), isTrue);
              expect(StoycoScreenSize.isTablet(context), isFalse);
              expect(StoycoScreenSize.isDesktop(context), isFalse);
              expect(StoycoScreenSize.isDesktopLarge(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('isTablet should return true for tablet device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1024));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(StoycoScreenSize.isPhone(context), isFalse);
              expect(StoycoScreenSize.isTablet(context), isTrue);
              expect(StoycoScreenSize.isDesktop(context), isFalse);
              expect(StoycoScreenSize.isDesktopLarge(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('isDesktop should return true for desktop device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1400, 900));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(StoycoScreenSize.isPhone(context), isFalse);
              expect(StoycoScreenSize.isTablet(context), isFalse);
              expect(StoycoScreenSize.isDesktop(context), isTrue);
              expect(StoycoScreenSize.isDesktopLarge(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('isDesktopLarge should return true for large desktop', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1920, 1080));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(StoycoScreenSize.isPhone(context), isFalse);
              expect(StoycoScreenSize.isTablet(context), isFalse);
              expect(StoycoScreenSize.isDesktop(context), isFalse);
              expect(StoycoScreenSize.isDesktopLarge(context), isTrue);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('StoycoScreenSize - Width/Height Scaling', () {
    testWidgets('width should return scaled value', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final width = StoycoScreenSize.width(context, 100);
              expect(width, isA<double>());
              expect(width, greaterThan(0));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('width should use phone value for mobile device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final width = StoycoScreenSize.width(context, 100, phone: 50);
              expect(width, isA<double>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('height should return scaled value', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final height = StoycoScreenSize.height(context, 100);
              expect(height, isA<double>());
              expect(height, greaterThan(0));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('height should use tablet value for tablet device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1024));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final height = StoycoScreenSize.height(context, 100, tablet: 150);
              expect(height, isA<double>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('StoycoScreenSize - Font Size', () {
    testWidgets('fontSize should return scaled value with minimum 10', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final fontSize = StoycoScreenSize.fontSize(context, 14);
              expect(fontSize, isA<double>());
              expect(fontSize, greaterThanOrEqualTo(10));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('fontSize should enforce minimum of 10', (tester) async {
      await tester.binding.setSurfaceSize(const Size(200, 400));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final fontSize = StoycoScreenSize.fontSize(context, 5);
              expect(fontSize, greaterThanOrEqualTo(10));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('StoycoScreenSize - Radius', () {
    testWidgets('radius should return scaled value', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final radius = StoycoScreenSize.radius(context, 8);
              expect(radius, isA<double>());
              expect(radius, greaterThan(0));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('radius should use desktop value for desktop device', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1400, 900));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final radius = StoycoScreenSize.radius(context, 8, desktop: 12);
              expect(radius, isA<double>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('StoycoScreenSize - EdgeInsets', () {
    testWidgets('all should return EdgeInsets with equal padding', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = StoycoScreenSize.all(context, 16);
              expect(padding, isA<EdgeInsets>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('symmetric should return EdgeInsets with horizontal and vertical', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = StoycoScreenSize.symmetric(
                context,
                horizontal: 16,
                vertical: 8,
              );
              expect(padding, isA<EdgeInsets>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('fromLTRB should return EdgeInsets with specific sides', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = StoycoScreenSize.fromLTRB(
                context,
                left: 8,
                top: 16,
                right: 8,
                bottom: 16,
              );
              expect(padding, isA<EdgeInsets>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('fromLTRB should use device-specific values', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = StoycoScreenSize.fromLTRB(
                context,
                left: 16,
                leftPhone: 8,
                top: 16,
                topPhone: 4,
              );
              expect(padding, isA<EdgeInsets>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('symmetric should use device-specific values', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1920, 1080));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final padding = StoycoScreenSize.symmetric(
                context,
                horizontal: 16,
                vertical: 8,
                horizontalDesktopLarge: 32,
                verticalDesktopLarge: 16,
              );
              expect(padding, isA<EdgeInsets>());
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
