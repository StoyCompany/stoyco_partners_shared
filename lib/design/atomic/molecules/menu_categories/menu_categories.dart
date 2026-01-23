import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/items/category_item.dart';
import 'package:stoyco_partners_shared/design/models/category_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

/// {@template menu_categories}
/// A horizontal scrollable menu of selectable category items.
///
/// This component is a **Molecule** in the Atomic Design system, composed of
/// multiple [CategoryItem] atoms arranged in a horizontal scrollable row.
///
/// The [MenuCategories] widget supports:
///
/// * Multiple category selection
/// * Initial selection state via [initialSelectedIndices]
/// * Callback notification when selection changes via [onSelectionChanged]
/// * Alert callback when attempting to deselect the last item via [onLastItemDeselectionAttempt]
/// * Automatic spacing between items (20px)
/// * Always maintains at least one selected item
///
/// The widget prevents deselecting the last remaining selected item to ensure
/// at least one category is always active.
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to create a [MenuCategories] with initial selection.
///
/// ```dart
/// MenuCategories(
///   items: [
///     CategoryItemModel(
///       name: 'Food',
///       colorSelector: Colors.blue,
///       colorUnselected: Colors.grey,
///     ),
///     CategoryItemModel(
///       name: 'Drinks',
///       colorSelector: Colors.green,
///       colorUnselected: Colors.grey,
///     ),
///   ],
///   initialSelectedIndices: [0],
///   onSelectionChanged: (indices) {
///     print('Selected categories: $indices');
///   },
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CategoryItem], the atom used to display individual categories.
///  * [CategoryItemModel], the data model for category items.
///  * [SingleChildScrollView], used for horizontal scrolling.
class MenuCategories extends StatefulWidget {
  /// {@macro menu_categories}
  ///
  /// Creates a [MenuCategories] widget.
  ///
  /// The [items] argument must not be null and should contain at least one item.
  const MenuCategories({
    super.key,
    required this.items,
    this.onSelectionChanged,
    this.onAlertLastItemDeselectionAttempt,
    this.initialSelectedIndices,
  });

  /// The list of category items to display in the menu.
  ///
  /// Each item contains the category name, selected color, and unselected color.
  final List<CategoryItemModel> items;

  /// Called when the selection state changes.
  ///
  /// The callback receives a list of currently selected indices.
  /// This can be null if selection tracking is not needed.
  final void Function(List<int> selectedIndices)? onSelectionChanged;

  /// Called when the user attempts to deselect the last remaining selected item.
  ///
  /// This callback can be used to show an alert or message to the user
  /// explaining that at least one category must remain selected.
  /// The callback receives the index of the item that couldn't be deselected.
  final void Function(int index)? onAlertLastItemDeselectionAttempt;

  /// The initial indices of selected items.
  ///
  /// If null or empty, the first item (index 0) will be selected by default.
  /// Multiple indices can be provided for multi-selection.
  final List<int>? initialSelectedIndices;

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  late List<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedIndices != null && widget.initialSelectedIndices!.isNotEmpty) {
      _selectedIndices = List<int>.from(widget.initialSelectedIndices!);
    } else {
      _selectedIndices = <int>[0];
    }
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        if (_selectedIndices.length > 1) {
          _selectedIndices.remove(index);
        } else {
          widget.onAlertLastItemDeselectionAttempt?.call(index);
        }
      } else {
        _selectedIndices.add(index);
      }
    });
    
    widget.onSelectionChanged?.call(List<int>.from(_selectedIndices));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate(
          widget.items.length,
          (int index) {
            final CategoryItemModel item = widget.items[index];
            return Padding(
              padding: EdgeInsets.only(
                right: index < widget.items.length - 1 
                    ? StoycoScreenSize.width(context, 20) 
                    : 0,
              ),
              child: InkWell(
                onTap: () => _toggleSelection(index),
                child: CategoryItem(
                  colorSelector: item.colorSelector,
                  colorUnselected: item.colorUnselected,
                  name: item.name,
                  isSelected: _selectedIndices.contains(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
