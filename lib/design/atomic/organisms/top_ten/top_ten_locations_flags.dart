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

    // Obtener las categorías del primer elemento para el header
    final bool hasMultipleValues = widget.data.first.values.length > 1;

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: StoycoScreenSize.screenWidth(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header con círculos de colores (solo si hay múltiples valores)
            if (hasMultipleValues) _ColorHeader(values: widget.data.first.values),

            // Lista de items
            ...List<Widget>.generate(widget.data.length, (int index) {
              final double delay = index * 0.1;
              return _TopTenLocationItem(
                data: widget.data[index],
                position: index + 1,
                showColorCircles: false,
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
        ),
      ),
    );
  }
}

class _ColorHeader extends StatelessWidget {
  const _ColorHeader({required this.values});

  final List<TopTenLocationsValue> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: StoycoScreenSize.height(context, 8)),
      child: Row(
        children: <Widget>[
          // Espaciado para alinear con los valores
          Gap(StoycoScreenSize.width(context, 24)), // position
          Gap(StoycoScreenSize.width(context, 8)), // spacing
          Gap(StoycoScreenSize.width(context, 24)), // flag
          Gap(StoycoScreenSize.width(context, 8)), // spacing
          SizedBox(
            width: StoycoScreenSize.screenWidth(context) * 0.25,
          ), // location name

          Gap(StoycoScreenSize.width(context, 12)), // spacer
          // Círculos de colores
          ...values.asMap().entries.map((
            MapEntry<int, TopTenLocationsValue> entry,
          ) {
            final int index = entry.key;
            final TopTenLocationsValue value = entry.value;

            return Padding(
              padding: EdgeInsets.only(
                left: index > 0 ? StoycoScreenSize.width(context, 6) : 0,
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
          }),
        ],
      ),
    );
  }
}

class _TopTenLocationItem extends StatelessWidget {
  const _TopTenLocationItem({
    required this.data,
    required this.position,
    required this.animation,
    required this.showColorCircles,
  });

  final TopTenLocationsData data;
  final int position;
  final Animation<double> animation;
  final bool showColorCircles;

  @override
  Widget build(BuildContext context) {
    final bool hasMultipleValues = data.values.length > 1;

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
                width: StoycoScreenSize.screenWidth(context) * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Position number
                    SizedBox(
                      width: StoycoScreenSize.width(context, 24),
                      child: Text(
                        '$position.',
                        style: TextStyle(
                          fontSize: StoycoScreenSize.width(context, 14),
                          color: ColorFoundation.text.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: StoycoFontFamilyToken.gilroy,
                        ),
                      ),
                    ),
                    Gap(StoycoScreenSize.width(context, 4)),
                    // Flag
                    ConuntryFlag(
                      conuntryCode: data.codeFlag,
                      width: StoycoScreenSize.width(context, 24),
                      height: StoycoScreenSize.height(context, 16),
                      borderRadius: 2,
                    ),
                    Gap(StoycoScreenSize.width(context, 4)),
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
                    // Spacer para separar el nombre de los valores
                    Gap(StoycoScreenSize.width(context, 8)),
                    // Right side: Values aligned to the right
                    if (hasMultipleValues)
                      _MultipleValuesSection(
                        values: data.values,
                        showColorCircles: showColorCircles,
                      )
                    else
                      _SingleValueSection(value: data.values.first.value),
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
        fontSize: StoycoScreenSize.width(context, 14),
        color: ColorFoundation.text.white,
        fontWeight: FontWeight.bold,
        fontFamily: StoycoFontFamilyToken.gilroy,
      ),
    );
  }
}

class _MultipleValuesSection extends StatelessWidget {
  const _MultipleValuesSection({
    required this.values,
    required this.showColorCircles,
  });

  final List<TopTenLocationsValue> values;
  final bool showColorCircles;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values.asMap().entries.map((
        MapEntry<int, TopTenLocationsValue> entry,
      ) {
        final int index = entry.key;
        final TopTenLocationsValue value = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            left: index > 0 ? StoycoScreenSize.width(context, 6) : 0,
          ),
          child: SizedBox(
            width: StoycoScreenSize.width(context, 50),
            child: Center(
              child: Text(
                NumbersFormat.formatCompact(value.value),
                style: TextStyle(
                  fontSize: StoycoScreenSize.width(context, 14),
                  color: ColorFoundation.text.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: StoycoFontFamilyToken.gilroy,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
