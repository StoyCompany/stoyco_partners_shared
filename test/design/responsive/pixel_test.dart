import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';

void main() {
  group('LayoutPixelFormat', () {
    test('should have correct enum values', () {
      expect(LayoutPixelFormat.values.length, 2);
      expect(LayoutPixelFormat.values, contains(LayoutPixelFormat.logical));
      expect(LayoutPixelFormat.values, contains(LayoutPixelFormat.physical));
    });

    test('should have correct index values', () {
      expect(LayoutPixelFormat.logical.index, 0);
      expect(LayoutPixelFormat.physical.index, 1);
    });

    test('enum values should be distinct', () {
      expect(LayoutPixelFormat.logical, isNot(LayoutPixelFormat.physical));
    });

    test('should be able to switch on enum', () {
      final logical = LayoutPixelFormat.logical;
      final physical = LayoutPixelFormat.physical;

      String getDescription(LayoutPixelFormat format) {
        switch (format) {
          case LayoutPixelFormat.logical:
            return 'logical';
          case LayoutPixelFormat.physical:
            return 'physical';
        }
      }

      expect(getDescription(logical), 'logical');
      expect(getDescription(physical), 'physical');
    });
  });
}
