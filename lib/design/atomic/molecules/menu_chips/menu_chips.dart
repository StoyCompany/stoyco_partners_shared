import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/items/menu_item_chip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

/// {@template menu_chips}
/// A horizontal scrollable menu of chip items with associated content pages.
///
/// This component is a **Molecule** in the Atomic Design system, composed of
/// multiple [MenuItemChip] atoms arranged in a horizontal scrollable row,
/// with an [IndexedStack] to display content associated with each chip.
///
/// The [MenuChips] widget features:
///
/// * Horizontal scrollable chip menu
/// * Single selection mode (one chip active at a time)
/// * IndexedStack for efficient content switching (preserves page state)
/// * Initial selection via [initialSelectedIndex]
/// * Callback notification when selection changes via [onSelectionChanged]
/// * Automatic spacing between chips (10px)
/// * Optional content pages corresponding to each chip
///
/// The widget efficiently manages multiple content pages using [IndexedStack],
/// which only builds the currently visible page while preserving the state
/// of other pages.
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to create a [MenuChips] with content pages.
///
/// ```dart
/// MenuChips(
///   labels: ['Pizza', 'Burger', 'Salad'],
///   contentPages: [
///     PizzaPage(),
///     BurgerPage(),
///     SaladPage(),
///   ],
///   initialSelectedIndex: 0,
///   onSelectionChanged: (index) {
///     print('Selected chip: $index');
///   },
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [MenuItemChip], the atom used to display individual chips.
///  * [MenuCategories], a similar molecule for category selection.
///  * [IndexedStack], used for efficient content page management.
class MenuChips extends StatefulWidget {
  /// {@macro menu_chips}
  ///
  /// Creates a [MenuChips] widget.
  ///
  /// The [labels] argument must not be null and should contain at least one item.
  /// If [contentPages] is provided, it must have the same length as [labels].
  const MenuChips({
    super.key,
    required this.labels,
    this.contentPages,
    this.initialSelectedIndex = 0,
    this.onSelectionChanged,
  }) : assert(
          contentPages == null || contentPages.length == labels.length,
          'contentPages length must match labels length',
        );

  /// The list of labels to display in the chip menu.
  ///
  /// Each label corresponds to a chip button.
  final List<String> labels;

  /// Optional list of content pages corresponding to each chip.
  ///
  /// If provided, must have the same length as [labels].
  /// Uses [IndexedStack] to efficiently manage page state.
  final List<Widget>? contentPages;

  /// The initial index of the selected chip.
  ///
  /// Defaults to 0 (first chip).
  final int initialSelectedIndex;

  /// Called when the selection changes.
  ///
  /// The callback receives the newly selected index.
  final ValueChanged<int>? onSelectionChanged;

  @override
  State<MenuChips> createState() => _MenuChipsState();
}

class _MenuChipsState extends State<MenuChips> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _onChipTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onSelectionChanged?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: StoycoScreenSize.fromLTRB(
            context,
            left: 5,
            right: 10,
          ),
          child: Row(
            children: List<Widget>.generate(
              widget.labels.length,
              (int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < widget.labels.length - 1
                        ? StoycoScreenSize.width(context, 10)
                        : 0,
                  ),
                  child: MenuItemChip(
                    label: widget.labels[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => _onChipTap(index),
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.contentPages != null)
          IndexedStack(
            index: _selectedIndex,
            sizing: StackFit.loose,
            children: widget.contentPages!,
          ),
      ],
    );
  }
}
