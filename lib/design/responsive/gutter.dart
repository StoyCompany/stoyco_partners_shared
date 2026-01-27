import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';

/// Gutter es un widget que proporciona un espacio (gap) entre elementos en un diseño.
/// El tamaño del espacio puede ser personalizado o determinado por el contexto de diseño.

class Gutter extends StatelessWidget {
  const Gutter([
    this.extent,
    Key? key,
  ]) : super(key: key);

  final double? extent;

  /// Método estático que separa una lista de widgets con un espacio (gap) entre ellos.
  static List<Widget> separateChildren({
    required List<Widget> children,
    double? extent,
  }) =>
      children.separate(extent);

  @override
  Widget build(BuildContext context) {
    return Gap(extent ?? context.layout.gutter);
  }
}

/// SliverGutter es un widget que proporciona un espacio (gap) entre elementos en un diseño sliver.
/// El tamaño del espacio puede ser personalizado o determinado por el contexto de diseño.
class SliverGutter extends StatelessWidget {
  const SliverGutter([
    this.extent,
    Key? key,
  ]) : super(key: key);
  final double? extent;

  @override
  Widget build(BuildContext context) {
    return SliverGap(extent ?? context.layout.gutter);
  }
}

extension ListGutter on List<Widget> {
  List<Widget> separate(double? extend) => length <= 1
    ? this
    : sublist(1).fold(
      <Widget>[first],
      (List<Widget> r, Widget element) => <Widget>[...r, Gutter(extend), element],
    );
}
