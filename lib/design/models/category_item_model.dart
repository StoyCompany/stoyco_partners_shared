import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class CategoryItemModel extends Equatable {
  const CategoryItemModel({
    required this.id,
    required this.colorSelector,
    required this.colorUnselected,
    required this.name,
    this.isSelected = false,
  });

  final String id;
  final Color colorSelector;
  final Color colorUnselected;
  final String name;
  final bool isSelected;

  @override
  List<Object?> get props => <Object?>[colorSelector, colorUnselected, name, isSelected,];
}
