import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';

class Gutter extends StatelessWidget {
  const Gutter([this.extent, Key? key]) : super(key: key);

  final double? extent;

  static List<Widget> separateChildren({
    required List<Widget> children,
    double? extent,
  }) => children.separate(extent);

  @override
  Widget build(BuildContext context) {
    return Gap(extent ?? context.layout.gutter);
  }
}

class SliverGutter extends StatelessWidget {
  const SliverGutter([this.extent, Key? key]) : super(key: key);
  final double? extent;

  @override
  Widget build(BuildContext context) {
    return SliverGap(extent ?? context.layout.gutter);
  }
}

extension ListGutter on List<Widget> {
  List<Widget> separate([double? extent]) {
    if (isEmpty || length == 1) return this;

    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(Gutter(extent));
      }
    }
    return result;
  }
}
