import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/items/category_item.dart';
import 'package:stoyco_partners_shared/design/models/category_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

class MenuCategories extends StatefulWidget {
  const MenuCategories({
    super.key,
    required this.items,
    this.onSelectionChanged,
    this.initialSelectedIndices,
  });

  final List<CategoryItemModel> items;
  final void Function(List<int> selectedIndices)? onSelectionChanged;
  final List<int>? initialSelectedIndices;

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  late List<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    // Inicializar con índices seleccionados o el primero por defecto
    if (widget.initialSelectedIndices != null && widget.initialSelectedIndices!.isNotEmpty) {
      _selectedIndices = List<int>.from(widget.initialSelectedIndices!);
    } else {
      _selectedIndices = <int>[0];
    }
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        // No permitir desseleccionar si solo hay uno seleccionado
        if (_selectedIndices.length > 1) {
          _selectedIndices.remove(index);
        }
      } else {
        _selectedIndices.add(index);
      }
    });
    
    // Notificar cambios
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
