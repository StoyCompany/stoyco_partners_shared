import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/models/bubble_data_model.dart';
import 'package:stoyco_partners_shared/design/models/category_item_model.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/models/pie_chart_section_data.dart';
import 'package:stoyco_partners_shared/design/models/selector_item.dart';
import 'package:stoyco_partners_shared/design/models/top_ten_locations_data_model.dart';

void main() {
  group('BubbleData', () {
    test('should create BubbleData with value and color', () {
      final bubbleData = BubbleData(
        value: 100.0,
        color: Colors.blue,
      );

      expect(bubbleData.value, 100.0);
      expect(bubbleData.color, Colors.blue);
    });

    test('should handle different values', () {
      final bubble1 = BubbleData(value: 50.0, color: Colors.red);
      final bubble2 = BubbleData(value: 150.5, color: Colors.green);

      expect(bubble1.value, 50.0);
      expect(bubble2.value, 150.5);
    });
  });

  group('BubblePosition', () {
    test('should create BubblePosition with all properties', () {
      final bubbleData = BubbleData(value: 100.0, color: Colors.blue);
      final bubblePosition = BubblePosition(
        data: bubbleData,
        radius: 50.0,
        offset: const Offset(10, 20),
        angle: 45.0,
      );

      expect(bubblePosition.data, bubbleData);
      expect(bubblePosition.radius, 50.0);
      expect(bubblePosition.offset, const Offset(10, 20));
      expect(bubblePosition.angle, 45.0);
    });

    test('should handle negative offsets and angles', () {
      final bubbleData = BubbleData(value: 75.0, color: Colors.orange);
      final bubblePosition = BubblePosition(
        data: bubbleData,
        radius: 30.0,
        offset: const Offset(-5, -10),
        angle: -90.0,
      );

      expect(bubblePosition.offset.dx, -5);
      expect(bubblePosition.offset.dy, -10);
      expect(bubblePosition.angle, -90.0);
    });
  });

  group('CategoryItemModel', () {
    test('should create CategoryItemModel with required properties', () {
      const model = CategoryItemModel(
        id: '1',
        colorSelector: Colors.blue,
        colorUnselected: Colors.grey,
        name: 'Test Category',
      );

      expect(model.id, '1');
      expect(model.colorSelector, Colors.blue);
      expect(model.colorUnselected, Colors.grey);
      expect(model.name, 'Test Category');
      expect(model.isSelected, false);
    });

    test('should create CategoryItemModel with isSelected true', () {
      const model = CategoryItemModel(
        id: '2',
        colorSelector: Colors.red,
        colorUnselected: Colors.grey,
        name: 'Selected Category',
        isSelected: true,
      );

      expect(model.isSelected, true);
    });

    test('should support equality comparison', () {
      const model1 = CategoryItemModel(
        id: '1',
        colorSelector: Colors.blue,
        colorUnselected: Colors.grey,
        name: 'Test',
      );

      const model2 = CategoryItemModel(
        id: '1',
        colorSelector: Colors.blue,
        colorUnselected: Colors.grey,
        name: 'Test',
      );

      expect(model1, equals(model2));
    });

    test('should have correct props', () {
      const model = CategoryItemModel(
        id: '1',
        colorSelector: Colors.blue,
        colorUnselected: Colors.grey,
        name: 'Test',
        isSelected: true,
      );

      expect(model.props.length, 4);
      expect(model.props, contains(Colors.blue));
      expect(model.props, contains(Colors.grey));
      expect(model.props, contains('Test'));
      expect(model.props, contains(true));
    });
  });

  group('ChartLegendItemModel', () {
    test('should create ChartLegendItemModel with required properties', () {
      const model = ChartLegendItemModel(
        color: Colors.blue,
        label: 'Test Label',
      );

      expect(model.color, Colors.blue);
      expect(model.label, 'Test Label');
      expect(model.value, '');
    });

    test('should create ChartLegendItemModel with value', () {
      const model = ChartLegendItemModel(
        color: Colors.red,
        label: 'Revenue',
        value: '20%',
      );

      expect(model.color, Colors.red);
      expect(model.label, 'Revenue');
      expect(model.value, '20%');
    });

    test('should handle different value formats', () {
      const model1 = ChartLegendItemModel(
        color: Colors.green,
        label: 'Sales',
        value: '\$1,234',
      );

      const model2 = ChartLegendItemModel(
        color: Colors.orange,
        label: 'Users',
        value: '1.2M',
      );

      expect(model1.value, '\$1,234');
      expect(model2.value, '1.2M');
    });
  });

  group('PieChartSectionData', () {
    test('should create PieChartSectionData without label', () {
      const section = PieChartSectionData(
        value: 25.5,
        color: Colors.blue,
      );

      expect(section.value, 25.5);
      expect(section.color, Colors.blue);
      expect(section.label, isNull);
    });

    test('should create PieChartSectionData with label', () {
      const section = PieChartSectionData(
        value: 50.0,
        color: Colors.red,
        label: 'Section A',
      );

      expect(section.value, 50.0);
      expect(section.color, Colors.red);
      expect(section.label, 'Section A');
    });

    test('should handle zero and negative values', () {
      const section1 = PieChartSectionData(value: 0, color: Colors.grey);
      const section2 = PieChartSectionData(value: -10, color: Colors.black);

      expect(section1.value, 0);
      expect(section2.value, -10);
    });
  });

  group('SelectorItem', () {
    test('should create SelectorItem with String value', () {
      final item = SelectorItem<String>(
        label: 'Option 1',
        value: 'opt1',
      );

      expect(item.label, 'Option 1');
      expect(item.value, 'opt1');
    });

    test('should create SelectorItem with int value', () {
      final item = SelectorItem<int>(
        label: 'Age 25',
        value: 25,
      );

      expect(item.label, 'Age 25');
      expect(item.value, 25);
    });

    test('should create SelectorItem with custom object', () {
      final customObject = {'key': 'value'};
      final item = SelectorItem<Map<String, String>>(
        label: 'Custom',
        value: customObject,
      );

      expect(item.label, 'Custom');
      expect(item.value, customObject);
    });

    test('should support nullable generic type', () {
      final item = SelectorItem<String?>(
        label: 'None',
        value: null,
      );

      expect(item.label, 'None');
      expect(item.value, isNull);
    });
  });

  group('TopTenLocationsData', () {
    test('should create TopTenLocationsData and calculate total', () {
      final data = TopTenLocationsData(
        codeFlag: 'US',
        nameLocation: 'United States',
        values: [
          TopTenLocationsValue(
            value: 100.0,
            colorValue: Colors.blue,
            nameCategory: 'Category A',
          ),
          TopTenLocationsValue(
            value: 50.0,
            colorValue: Colors.red,
            nameCategory: 'Category B',
          ),
        ],
      );

      expect(data.codeFlag, 'US');
      expect(data.nameLocation, 'United States');
      expect(data.values.length, 2);
      expect(data.total, 150.0);
    });

    test('should calculate total as zero for empty values', () {
      final data = TopTenLocationsData(
        codeFlag: 'CA',
        nameLocation: 'Canada',
        values: [],
      );

      expect(data.total, 0.0);
      expect(data.values, isEmpty);
    });

    test('should handle single value', () {
      final data = TopTenLocationsData(
        codeFlag: 'UK',
        nameLocation: 'United Kingdom',
        values: [
          TopTenLocationsValue(
            value: 75.5,
            colorValue: Colors.green,
            nameCategory: 'Only Category',
          ),
        ],
      );

      expect(data.values.length, 1);
      expect(data.total, 75.5);
    });

    test('should calculate total correctly with multiple values', () {
      final data = TopTenLocationsData(
        codeFlag: 'FR',
        nameLocation: 'France',
        values: [
          TopTenLocationsValue(value: 10.5, colorValue: Colors.blue, nameCategory: 'A'),
          TopTenLocationsValue(value: 20.3, colorValue: Colors.red, nameCategory: 'B'),
          TopTenLocationsValue(value: 30.2, colorValue: Colors.green, nameCategory: 'C'),
        ],
      );

      expect(data.total, 61.0);
    });
  });

  group('TopTenLocationsValue', () {
    test('should create TopTenLocationsValue with all properties', () {
      final value = TopTenLocationsValue(
        value: 123.45,
        colorValue: Colors.purple,
        nameCategory: 'Test Category',
      );

      expect(value.value, 123.45);
      expect(value.colorValue, Colors.purple);
      expect(value.nameCategory, 'Test Category');
    });

    test('should handle different color values', () {
      final value1 = TopTenLocationsValue(
        value: 50.0,
        colorValue: const Color(0xFF123456),
        nameCategory: 'Custom Color',
      );

      final value2 = TopTenLocationsValue(
        value: 75.0,
        colorValue: const Color.fromARGB(255, 100, 200, 50),
        nameCategory: 'ARGB Color',
      );

      expect(value1.colorValue.value, 0xFF123456);
      expect(value2.colorValue.alpha, 255);
    });
  });
}
