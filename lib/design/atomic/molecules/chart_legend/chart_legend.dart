import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/chip_monotone_noise.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// {@template chart_legend}
/// A horizontal chart legend with color indicators, labels and values.
///
/// This component is a **Molecule** in the Atomic Design system, displaying
/// a list of chart legend items with color chips, labels, and percentage values.
///
/// The [ChartLegend] features:
///
/// * Color indicator chip (12x8px, rounded)
/// * Label text next to the indicator
/// * Percentage value displayed below using [ChipMonotoneNoise]
/// * Dynamic layout that adapts to screen width
/// * Maximum 4 items visible, scrolls horizontally if more
/// * Equal width distribution up to 4 items
///
/// Layout behavior:
/// - 1 item: 100% width
/// - 2 items: 50% width each
/// - 3 items: 33.3% width each
/// - 4 items: 25% width each
/// - 5+ items: Horizontal scroll with 25% width each
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to create a [ChartLegend].
///
/// ```dart
/// ChartLegend(
///   items: [
///     ChartLegendItemModel(
///       color: Color(0xFF3C80FF),
///       label: 'Category A',
///       value: '20%',
///     ),
///     ChartLegendItemModel(
///       color: Color(0xFFFF5733),
///       label: 'Category B',
///       value: '80%',
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ChipMonotoneNoise], used to display the percentage values.
///  * [ChartLegendItemModel], the data model for legend items.
class ChartLegend extends StatelessWidget {
  /// {@macro chart_legend}
  ///
  /// Creates a [ChartLegend] widget.
  ///
  /// The [items] argument must not be null and should contain at least one item.
  const ChartLegend({
    super.key,
    required this.items,
  });

  /// The list of legend items to display.
  final List<ChartLegendItemModel> items;

  @override
  Widget build(BuildContext context) {
    final int itemCount = items.length;
    final double itemWidth = StoycoScreenSize.screenWidth(context) / 4;

    final Widget content = Row(
      children: List<Widget>.generate(
        itemCount,
        (int index) => _ChartLegendItem(
          item: items[index],
          width: itemWidth,
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: content,
    );
  }
}

class _ChartLegendItem extends StatelessWidget {
  const _ChartLegendItem({
    required this.item,
    required this.width,
  });

  final ChartLegendItemModel item;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: StoycoScreenSize.width(context, 12),
                height: StoycoScreenSize.height(context, 8),
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(
                    StoycoScreenSize.radius(context, 100),
                  ),
                ),
              ),
              SizedBox(width: StoycoScreenSize.width(context, 8)),
              Flexible(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontWeight: FontWeight.w300,
                    fontSize: StoycoScreenSize.fontSize(context, 14),
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (item.value.isNotEmpty)...<Widget>[
            SizedBox(height: StoycoScreenSize.height(context, 8)),
            ChipMonotoneNoise(
              message: item.value,
              padding: StoycoScreenSize.symmetric(  context, horizontal: 20),
            ),
          ],
        ],
      ),
    );
  }
}
