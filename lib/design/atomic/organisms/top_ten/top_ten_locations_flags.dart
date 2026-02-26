import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/flags/country_flag.dart';
import 'package:stoyco_partners_shared/design/models/top_ten_locations_data_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class TopTenLocationsFlags extends StatefulWidget {
  const TopTenLocationsFlags({
    super.key,
    required this.data,
    this.animationDuration = const Duration(milliseconds: 1200),
  });

  final List<TopTenLocationsData> data;
  final Duration animationDuration;

  @override
  State<TopTenLocationsFlags> createState() => _TopTenLocationsFlagsState();
}

class _TopTenLocationsFlagsState extends State<TopTenLocationsFlags>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(TopTenLocationsFlags oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Sin ranking',
            style: TextStyle(
              fontSize: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        ),
      );
    }

    final List<Color> visibleCategoryColors = <Color>[];
    if (widget.data.first.values.isNotEmpty) {
      for (int i = 0; i < widget.data.first.values.length; i++) {
        final Color categoryColor = widget.data.first.values[i].colorValue;
        bool hasNonZeroValue = false;

        for (final TopTenLocationsData item in widget.data) {
          for (final TopTenLocationsValue value in item.values) {
            if (value.colorValue == categoryColor && value.value > 0) {
              hasNonZeroValue = true;
              break;
            }
          }
          if (hasNonZeroValue) {
            break;
          }
        }

        if (hasNonZeroValue && !visibleCategoryColors.contains(categoryColor)) {
          visibleCategoryColors.add(categoryColor);
        }
      }
    }

    final bool hasMultipleValues = visibleCategoryColors.length > 1;

    final double screenWidth = StoycoScreenSize.screenWidth(context);
    final double contentWidth = hasMultipleValues
        ? screenWidth * (0.80 + (visibleCategoryColors.length * 0.08))
        : screenWidth;

    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (hasMultipleValues)
          _ColorHeader(
            allValues: widget.data.first.values,
            visibleColors: visibleCategoryColors,
            contentWidth: contentWidth,
          ),

        ...List<Widget>.generate(widget.data.length, (int index) {
          final double delay = index * 0.1;
          return _TopTenLocationItem(
            data: widget.data[index],
            position: index + 1,
            visibleColors: visibleCategoryColors,
            contentWidth: contentWidth,
            animation: CurvedAnimation(
              parent: _controller,
              curve: Interval(
                delay,
                (delay + 0.3).clamp(0.0, 1.0),
                curve: Curves.easeOutCubic,
              ),
            ),
          );
        }),
      ],
    );

    if (!hasMultipleValues) {
      return content;
    }

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: SizedBox(width: contentWidth, child: content),
    );
  }
}

class _ColorHeader extends StatelessWidget {
  const _ColorHeader({
    required this.allValues,
    required this.visibleColors,
    required this.contentWidth,
  });

  final List<TopTenLocationsValue> allValues;
  final List<Color> visibleColors;
  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    final List<TopTenLocationsValue> visibleValues = allValues
        .where((TopTenLocationsValue v) => visibleColors.contains(v.colorValue))
        .toList();

    return Padding(
      padding: EdgeInsets.only(bottom: StoycoScreenSize.height(context, 8)),
      child: SizedBox(
        width: contentWidth,
        child: Row(
          children: <Widget>[
            const Expanded(child: SizedBox()),

            Gap(StoycoScreenSize.width(context, 16)),

            Row(
              children: visibleValues.asMap().entries.map((
                MapEntry<int, TopTenLocationsValue> entry,
              ) {
                final int displayIndex = entry.key;
                final TopTenLocationsValue value = entry.value;

                return Padding(
                  padding: EdgeInsets.only(
                    left: displayIndex > 0
                        ? StoycoScreenSize.width(context, 8)
                        : 0,
                  ),
                  child: SizedBox(
                    width: StoycoScreenSize.width(context, 50),
                    child: Center(
                      child: Container(
                        width: StoycoScreenSize.width(context, 12),
                        height: StoycoScreenSize.height(context, 12),
                        decoration: BoxDecoration(
                          color: value.colorValue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: value.colorValue.withOpacity(0.6),
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTenLocationItem extends StatelessWidget {
  const _TopTenLocationItem({
    required this.data,
    required this.position,
    required this.animation,
    required this.visibleColors,
    required this.contentWidth,
  });

  final TopTenLocationsData data;
  final int position;
  final Animation<double> animation;
  final List<Color> visibleColors;
  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    final bool hasMultipleValues = visibleColors.length > 1;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: StoycoScreenSize.height(context, 12),
              ),
              child: SizedBox(
                width: hasMultipleValues ? contentWidth : null,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: StoycoScreenSize.width(context, 27),
                      child: Text(
                        '$position.',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          package: 'stoyco_partners_shared',
                          fontSize: StoycoScreenSize.width(context, 14),
                          color: ColorFoundation.text.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: StoycoFontFamilyToken.apercu,
                        ),
                      ),
                    ),
                    Gap(StoycoScreenSize.width(context, 8)),
                    // Flag con tamaño fijo
                    ConuntryFlag(
                      conuntryCode: data.codeFlag,
                      width: StoycoScreenSize.width(context, 24),
                      height: StoycoScreenSize.height(context, 16),
                      borderRadius: 2,
                    ),
                    Gap(StoycoScreenSize.width(context, 8)),
                    // Location name with ellipsis - expandible
                    Expanded(
                      child: Text(
                        data.nameLocation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: StoycoScreenSize.width(context, 14),
                          color: ColorFoundation.text.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: StoycoFontFamilyToken.gilroy,
                        ),
                      ),
                    ),

                    // Espacio entre columnas
                    Gap(StoycoScreenSize.width(context, 16)),

                    // COLUMNA DERECHA: Valores
                    if (hasMultipleValues)
                      _MultipleValuesSection(
                        allValues: data.values,
                        visibleColors: visibleColors,
                      )
                    else if (visibleColors.isNotEmpty)
                      _SingleValueSection(
                        value: data.values
                            .firstWhere(
                              (TopTenLocationsValue v) =>
                                  v.colorValue == visibleColors.first,
                              orElse: () => data.values.first,
                            )
                            .value,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SingleValueSection extends StatelessWidget {
  const _SingleValueSection({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Text(
      NumbersFormat.formatWithCommas(value),
      style: TextStyle(
        package: 'stoyco_partners_shared',
        fontSize: StoycoScreenSize.width(context, 14),
        color: ColorFoundation.text.white,
        fontWeight: FontWeight.bold,
        fontFamily: StoycoFontFamilyToken.apercu,
      ),
    );
  }
}

class _MultipleValuesSection extends StatelessWidget {
  const _MultipleValuesSection({
    required this.allValues,
    required this.visibleColors,
  });

  final List<TopTenLocationsValue> allValues;
  final List<Color> visibleColors;

  @override
  Widget build(BuildContext context) {
    // Filtrar y ordenar valores según los colores visibles
    // Si un color no existe en allValues, mostrar 0
    final List<MapEntry<Color, double>> visibleValues =
        <MapEntry<Color, double>>[];
    for (final Color color in visibleColors) {
      final TopTenLocationsValue? value = allValues
          .cast<TopTenLocationsValue?>()
          .firstWhere(
            (TopTenLocationsValue? v) => v?.colorValue == color,
            orElse: () => null,
          );
      // Añadir el valor encontrado o 0 si no existe
      visibleValues.add(MapEntry<Color, double>(color, value?.value ?? 0));
    }

    return Row(
      children: visibleValues.asMap().entries.map((
        MapEntry<int, MapEntry<Color, double>> entry,
      ) {
        final int displayIndex = entry.key;
        final double value = entry.value.value;

        return Padding(
          padding: EdgeInsets.only(
            left: displayIndex > 0 ? StoycoScreenSize.width(context, 8) : 0,
          ),
          child: SizedBox(
            width: StoycoScreenSize.width(context, 50),
            child: Center(
              child: Text(
                NumbersFormat.formatCompact(value),
                style: TextStyle(
                  package: 'stoyco_partners_shared',
                  fontSize: StoycoScreenSize.width(context, 14),
                  color: ColorFoundation.text.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: StoycoFontFamilyToken.apercu,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
