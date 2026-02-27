import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';

void main() {
  group('Utility Tests', () {
    group('NumbersFormat', () {
      group('formatWithCommas', () {
        test('should format integers with commas', () {
          expect(NumbersFormat.formatWithCommas(1000), equals('1,000'));
          expect(NumbersFormat.formatWithCommas(1000000), equals('1,000,000'));
          expect(NumbersFormat.formatWithCommas(123456789), equals('123,456,789'));
        });

        test('should format small numbers without commas', () {
          expect(NumbersFormat.formatWithCommas(0), equals('0'));
          expect(NumbersFormat.formatWithCommas(100), equals('100'));
          expect(NumbersFormat.formatWithCommas(999), equals('999'));
        });

        test('should format negative numbers', () {
          expect(NumbersFormat.formatWithCommas(-1000), equals('-1,000'));
          expect(NumbersFormat.formatWithCommas(-1000000), equals('-1,000,000'));
        });

        test('should format decimal numbers', () {
          expect(NumbersFormat.formatWithCommas(1000.5), equals('1,000.5'));
          expect(NumbersFormat.formatWithCommas(1234567.89), equals('1,234,567.89'));
        });
      });

      group('formatCompact', () {
        test('should format large numbers compactly', () {
          expect(NumbersFormat.formatCompact(1000), equals('1k'));
          expect(NumbersFormat.formatCompact(1500), equals('1.5k'));
          expect(NumbersFormat.formatCompact(1000000), equals('1m'));
          expect(NumbersFormat.formatCompact(1500000), equals('1.5m'));
          expect(NumbersFormat.formatCompact(1000000000), equals('1mm'));
        });

        test('should not format small numbers', () {
          expect(NumbersFormat.formatCompact(0), equals('0'));
          expect(NumbersFormat.formatCompact(100), equals('100'));
          expect(NumbersFormat.formatCompact(999), equals('999'));
        });

        test('should handle edge cases', () {
          expect(NumbersFormat.formatCompact(1000.0), equals('1k'));
          expect(NumbersFormat.formatCompact(999999), equals('999.9k'));
        });
      });

      group('formatCurrency', () {
        test('should format currency with symbol', () {
          expect(NumbersFormat.formatCurrency(1000), contains('1,000'));
          expect(NumbersFormat.formatCurrency(1000000), contains('1,000,000'));
        });

        test('should format currency with decimals', () {
          final formatted = NumbersFormat.formatCurrency(1234.56);
          expect(formatted, contains('1,234.56'));
        });

        test('should handle zero', () {
          final formatted = NumbersFormat.formatCurrency(0);
          expect(formatted, contains('0'));
        });

        test('should handle negative amounts', () {
          final formatted = NumbersFormat.formatCurrency(-1000);
          expect(formatted, contains('1,000'));
        });
      });



      group('Edge Cases', () {
        test('should handle very large numbers', () {
          expect(NumbersFormat.formatWithCommas(999999999999), isNotEmpty);
          expect(NumbersFormat.formatCompact(999999999999), contains('mm'));
        });

        test('should handle very small decimals', () {
          expect(NumbersFormat.formatWithCommas(0.0001), equals('0.0001'));
        });

        test('should handle infinity', () {
          expect(() => NumbersFormat.formatWithCommas(double.infinity), returnsNormally);
        });

        test('should handle NaN', () {
          expect(() => NumbersFormat.formatWithCommas(double.nan), returnsNormally);
        });
      });
    });

    group('DatesFormats', () {
      group('formatDateDDMMYYYY', () {
        test('should format date correctly', () {
          final date = DateTime(2024, 1, 15);
          final formatted = DatesFormats.formatDateDDMMYYYY(date);
          
          expect(formatted, equals('15/01/2024'));
        });

        test('should handle single digit days and months', () {
          final date = DateTime(2024, 3, 5);
          final formatted = DatesFormats.formatDateDDMMYYYY(date);
          
          expect(formatted, equals('05/03/2024'));
        });

        test('should handle end of year', () {
          final date = DateTime(2024, 12, 31);
          final formatted = DatesFormats.formatDateDDMMYYYY(date);
          
          expect(formatted, equals('31/12/2024'));
        });

        test('should handle beginning of year', () {
          final date = DateTime(2024, 1, 1);
          final formatted = DatesFormats.formatDateDDMMYYYY(date);
          
          expect(formatted, equals('01/01/2024'));
        });
      });

      group('formatDateDDMMYYYYWithDashes', () {
        test('should format date with dashes', () {
          final date = DateTime(2024, 1, 15);
          final formatted = DatesFormats.formatDateDDMMYYYYWithDashes(date);
          
          expect(formatted, equals('15-01-2024'));
        });
      });

      group('Edge Cases', () {
        test('should handle leap year', () {
          final leapDay = DateTime(2024, 2, 29);
          final formatted = DatesFormats.formatDateDDMMYYYY(leapDay);
          
          expect(formatted, equals('29/02/2024'));
        });

        test('should handle century change', () {
          final date = DateTime(2000, 1, 1);
          final formatted = DatesFormats.formatDateDDMMYYYY(date);
          
          expect(formatted, equals('01/01/2000'));
        });

        test('should handle far future dates', () {
          final future = DateTime(2099, 12, 31);
          final formatted = DatesFormats.formatDateDDMMYYYY(future);
          
          expect(formatted, equals('31/12/2099'));
        });

        test('should handle historic dates', () {
          final historic = DateTime(1900, 1, 1);
          final formatted = DatesFormats.formatDateDDMMYYYY(historic);
          
          expect(formatted, equals('01/01/1900'));
        });
      });
    });

    group('Format Consistency', () {
      test('number formats should return strings', () {
        expect(NumbersFormat.formatWithCommas(1000), isA<String>());
        expect(NumbersFormat.formatCompact(1000), isA<String>());
        expect(NumbersFormat.formatCurrency(1000), isA<String>());
      });

      test('date formats should return strings', () {
        final date = DateTime(2024, 1, 15);
        expect(DatesFormats.formatDateDDMMYYYY(date), isA<String>());
        expect(DatesFormats.formatDateDDMMYYYYWithDashes(date), isA<String>());
      });

      test('formatted strings should not be empty', () {
        expect(NumbersFormat.formatWithCommas(0), isNotEmpty);
        expect(NumbersFormat.formatCompact(0), isNotEmpty);
        expect(DatesFormats.formatDateDDMMYYYY(DateTime.now()), isNotEmpty);
      });
    });
  });
}
