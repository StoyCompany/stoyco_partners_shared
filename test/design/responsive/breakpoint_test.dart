import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';

void main() {
  group('LayoutBreakpoint', () {
    group('Enum Values', () {
      test('should have all breakpoint values', () {
        expect(LayoutBreakpoint.values.length, 5);
        expect(LayoutBreakpoint.values, contains(LayoutBreakpoint.xs));
        expect(LayoutBreakpoint.values, contains(LayoutBreakpoint.sm));
        expect(LayoutBreakpoint.values, contains(LayoutBreakpoint.md));
        expect(LayoutBreakpoint.values, contains(LayoutBreakpoint.lg));
        expect(LayoutBreakpoint.values, contains(LayoutBreakpoint.xl));
      });

      test('should have correct index order', () {
        expect(LayoutBreakpoint.xs.index, 0);
        expect(LayoutBreakpoint.sm.index, 1);
        expect(LayoutBreakpoint.md.index, 2);
        expect(LayoutBreakpoint.lg.index, 3);
        expect(LayoutBreakpoint.xl.index, 4);
      });
    });

    group('smaller Extension', () {
      test('xs should return null (no smaller breakpoint)', () {
        expect(LayoutBreakpoint.xs.smaller, isNull);
      });

      test('sm should return xs', () {
        expect(LayoutBreakpoint.sm.smaller, LayoutBreakpoint.xs);
      });

      test('md should return sm', () {
        expect(LayoutBreakpoint.md.smaller, LayoutBreakpoint.sm);
      });

      test('lg should return md', () {
        expect(LayoutBreakpoint.lg.smaller, LayoutBreakpoint.md);
      });

      test('xl should return lg', () {
        expect(LayoutBreakpoint.xl.smaller, LayoutBreakpoint.lg);
      });

      test('should create valid chain from xl to xs', () {
        var current = LayoutBreakpoint.xl;
        final chain = <LayoutBreakpoint>[current];
        
        while (current.smaller != null) {
          current = current.smaller!;
          chain.add(current);
        }

        expect(chain, [
          LayoutBreakpoint.xl,
          LayoutBreakpoint.lg,
          LayoutBreakpoint.md,
          LayoutBreakpoint.sm,
          LayoutBreakpoint.xs,
        ]);
      });
    });

    group('bigger Extension', () {
      test('xs should return sm', () {
        expect(LayoutBreakpoint.xs.bigger, LayoutBreakpoint.sm);
      });

      test('sm should return md', () {
        expect(LayoutBreakpoint.sm.bigger, LayoutBreakpoint.md);
      });

      test('md should return lg', () {
        expect(LayoutBreakpoint.md.bigger, LayoutBreakpoint.lg);
      });

      test('lg should return xl', () {
        expect(LayoutBreakpoint.lg.bigger, LayoutBreakpoint.xl);
      });

      test('xl should return null (no bigger breakpoint)', () {
        expect(LayoutBreakpoint.xl.bigger, isNull);
      });

      test('should create valid chain from xs to xl', () {
        var current = LayoutBreakpoint.xs;
        final chain = <LayoutBreakpoint>[current];
        
        while (current.bigger != null) {
          current = current.bigger!;
          chain.add(current);
        }

        expect(chain, [
          LayoutBreakpoint.xs,
          LayoutBreakpoint.sm,
          LayoutBreakpoint.md,
          LayoutBreakpoint.lg,
          LayoutBreakpoint.xl,
        ]);
      });
    });

    group('Boolean Getters', () {
      test('isXs should be true only for xs', () {
        expect(LayoutBreakpoint.xs.isXs, isTrue);
        expect(LayoutBreakpoint.sm.isXs, isFalse);
        expect(LayoutBreakpoint.md.isXs, isFalse);
        expect(LayoutBreakpoint.lg.isXs, isFalse);
        expect(LayoutBreakpoint.xl.isXs, isFalse);
      });

      test('isSm should be true only for sm', () {
        expect(LayoutBreakpoint.xs.isSm, isFalse);
        expect(LayoutBreakpoint.sm.isSm, isTrue);
        expect(LayoutBreakpoint.md.isSm, isFalse);
        expect(LayoutBreakpoint.lg.isSm, isFalse);
        expect(LayoutBreakpoint.xl.isSm, isFalse);
      });

      test('isMd should be true only for md', () {
        expect(LayoutBreakpoint.xs.isMd, isFalse);
        expect(LayoutBreakpoint.sm.isMd, isFalse);
        expect(LayoutBreakpoint.md.isMd, isTrue);
        expect(LayoutBreakpoint.lg.isMd, isFalse);
        expect(LayoutBreakpoint.xl.isMd, isFalse);
      });

      test('isLg should be true only for lg', () {
        expect(LayoutBreakpoint.xs.isLg, isFalse);
        expect(LayoutBreakpoint.sm.isLg, isFalse);
        expect(LayoutBreakpoint.md.isLg, isFalse);
        expect(LayoutBreakpoint.lg.isLg, isTrue);
        expect(LayoutBreakpoint.xl.isLg, isFalse);
      });

      test('isXl should be true only for xl', () {
        expect(LayoutBreakpoint.xs.isXl, isFalse);
        expect(LayoutBreakpoint.sm.isXl, isFalse);
        expect(LayoutBreakpoint.md.isXl, isFalse);
        expect(LayoutBreakpoint.lg.isXl, isFalse);
        expect(LayoutBreakpoint.xl.isXl, isTrue);
      });

      test('all breakpoints should have exactly one boolean getter as true', () {
        for (final breakpoint in LayoutBreakpoint.values) {
          final booleans = [
            breakpoint.isXs,
            breakpoint.isSm,
            breakpoint.isMd,
            breakpoint.isLg,
            breakpoint.isXl,
          ];
          expect(booleans.where((b) => b).length, 1);
        }
      });
    });

    group('Comparison Operators', () {
      test('< operator should compare correctly', () {
        expect(LayoutBreakpoint.xs < LayoutBreakpoint.sm, isTrue);
        expect(LayoutBreakpoint.xs < LayoutBreakpoint.md, isTrue);
        expect(LayoutBreakpoint.sm < LayoutBreakpoint.lg, isTrue);
        expect(LayoutBreakpoint.md < LayoutBreakpoint.xl, isTrue);
        
        expect(LayoutBreakpoint.sm < LayoutBreakpoint.xs, isFalse);
        expect(LayoutBreakpoint.xl < LayoutBreakpoint.lg, isFalse);
        expect(LayoutBreakpoint.md < LayoutBreakpoint.md, isFalse);
      });

      test('> operator should compare correctly', () {
        expect(LayoutBreakpoint.sm > LayoutBreakpoint.xs, isTrue);
        expect(LayoutBreakpoint.md > LayoutBreakpoint.xs, isTrue);
        expect(LayoutBreakpoint.lg > LayoutBreakpoint.sm, isTrue);
        expect(LayoutBreakpoint.xl > LayoutBreakpoint.md, isTrue);
        
        expect(LayoutBreakpoint.xs > LayoutBreakpoint.sm, isFalse);
        expect(LayoutBreakpoint.lg > LayoutBreakpoint.xl, isFalse);
        expect(LayoutBreakpoint.md > LayoutBreakpoint.md, isFalse);
      });

      test('should maintain consistent ordering across all breakpoints', () {
        final ordered = [
          LayoutBreakpoint.xs,
          LayoutBreakpoint.sm,
          LayoutBreakpoint.md,
          LayoutBreakpoint.lg,
          LayoutBreakpoint.xl,
        ];

        for (var i = 0; i < ordered.length; i++) {
          for (var j = i + 1; j < ordered.length; j++) {
            expect(ordered[i] < ordered[j], isTrue,
                reason: '${ordered[i]} should be < ${ordered[j]}');
            expect(ordered[j] > ordered[i], isTrue,
                reason: '${ordered[j]} should be > ${ordered[i]}');
          }
        }
      });

      test('comparison operators should be transitive', () {
        expect(LayoutBreakpoint.xs < LayoutBreakpoint.sm, isTrue);
        expect(LayoutBreakpoint.sm < LayoutBreakpoint.md, isTrue);
        expect(LayoutBreakpoint.xs < LayoutBreakpoint.md, isTrue);
      });
    });

    group('Edge Cases', () {
      test('smaller and bigger should be inverse operations', () {
        expect(LayoutBreakpoint.sm.smaller?.bigger, LayoutBreakpoint.sm);
        expect(LayoutBreakpoint.md.smaller?.bigger, LayoutBreakpoint.md);
        expect(LayoutBreakpoint.lg.smaller?.bigger, LayoutBreakpoint.lg);
        expect(LayoutBreakpoint.xl.smaller?.bigger, LayoutBreakpoint.xl);
        
        expect(LayoutBreakpoint.xs.bigger?.smaller, LayoutBreakpoint.xs);
        expect(LayoutBreakpoint.sm.bigger?.smaller, LayoutBreakpoint.sm);
        expect(LayoutBreakpoint.md.bigger?.smaller, LayoutBreakpoint.md);
        expect(LayoutBreakpoint.lg.bigger?.smaller, LayoutBreakpoint.lg);
      });

      test('boundary breakpoints should handle null correctly', () {
        expect(LayoutBreakpoint.xs.smaller, isNull);
        expect(LayoutBreakpoint.xl.bigger, isNull);
        
        // These should not throw
        expect(() => LayoutBreakpoint.xs.smaller?.smaller, returnsNormally);
        expect(() => LayoutBreakpoint.xl.bigger?.bigger, returnsNormally);
      });
    });
  });
}
