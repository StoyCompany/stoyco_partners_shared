import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/models/selector_item.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// {@template selector}
/// A customizable selector button that opens a bottom sheet modal with options.
///
/// ### Atomic Level
/// **Molecule** – Combination of UI elements for selection input with modal interaction.
///
/// ### Parameters
/// - `items`: List of string options to display in the modal.
/// - `initialValue`: The initial selected value.
/// - `onChanged`: Callback when a new value is selected.
/// - `modalTitle`: Title displayed at the top of the modal. Defaults to "Ordenar Por".
///
/// ### Returns
/// A button that opens a bottom sheet with selectable options.
///
/// ### Example
/// ```dart
/// Selector(
///   items: ['Todos', 'Últimos 20 días', 'Último mes'],
///   initialValue: 'Todos',
///   onChanged: (value) => print(value),
/// )
/// ```
/// {@endtemplate}
class Selector<T> extends StatefulWidget {
  /// {@macro selector}
  const Selector({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.modalTitle = 'Ordenar Por',
  });

  /// List of string options to display in the modal.
  final List<SelectorItem<T>> items;

  /// The initial selected value.
  final SelectorItem<T> initialValue;

  /// Callback when a new value is selected.
  final ValueChanged<SelectorItem<T>> onChanged;

  /// Title displayed at the top of the modal. Defaults to "Ordenar Por".
  final String modalTitle;

  @override
  State<Selector<T>> createState() => _SelectorState<T>();
}

class _SelectorState<T> extends State<Selector<T>> {
  /// The currently selected value maintained internally.
  late SelectorItem<T> _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(Selector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
  }

  /// Opens a bottom sheet modal displaying all available options.
  ///
  /// The modal includes:
  /// - A title at the top
  /// - A scrollable list of options
  /// - Automatic scroll to the currently selected item
  /// - Visual highlighting of the selected option
  /// - Dividers between unselected items
  void _showModal(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int selectedIndex = widget.items.indexWhere((SelectorItem<T> item) => item.label == _selectedValue.label);
      if (selectedIndex > 0 && scrollController.hasClients) {
        final double itemHeight = StoycoScreenSize.height(context, 50);
        final double targetPosition = selectedIndex * itemHeight;

        scrollController.animateTo(
          targetPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: StoycoScreenSize.screenHeight(context) * 0.4,
          ),
          decoration: BoxDecoration(
            color: ColorFoundation.background.saLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(StoycoScreenSize.width(context, 30)),
              topRight: Radius.circular(StoycoScreenSize.width(context, 30)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: StoycoScreenSize.height(context, 20),
                  bottom: StoycoScreenSize.height(context, 15),
                  left: StoycoScreenSize.width(context, 19),
                  right: StoycoScreenSize.width(context, 19),
                ),
                child: Text(
                  widget.modalTitle,
                  style: TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontWeight: FontWeight.bold,
                    fontSize: StoycoScreenSize.width(context, 22),
                    color: ColorFoundation.text.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Flexible(
                child: ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: StoycoScreenSize.width(context, 19),
                  ),
                  itemCount: widget.items.length,
                  separatorBuilder: (BuildContext context, int index) {
                    final SelectorItem<T> currentItem = widget.items[index];
                    final bool isCurrentSelected = currentItem.label == _selectedValue.label;

                    final bool isNextSelected = index + 1 < widget.items.length && widget.items[index + 1].label == _selectedValue.label;
                    if (isCurrentSelected || isNextSelected) {
                      return const SizedBox.shrink();
                    }

                    return Divider(
                      height: 1,
                      thickness: 1,
                      color: ColorFoundation.background.saDark.withOpacity(0.5),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final SelectorItem<T> item = widget.items[index];
                    final bool isSelected = item.label == _selectedValue.label;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedValue = item;
                        });
                        widget.onChanged(item);
                        Navigator.pop(modalContext);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: StoycoScreenSize.height(context, 15),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorFoundation.background.saHighlights
                              : Colors.transparent,
                          borderRadius: isSelected
                              ? BorderRadius.circular(
                                  StoycoScreenSize.width(context, 50),
                                )
                              : null,
                        ),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w400,
                            fontSize: StoycoScreenSize.width(context, 16),
                            color: ColorFoundation.text.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Gap(StoycoScreenSize.height(context, 10)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModal(context),
      child: Container(
        height: StoycoScreenSize.height(context, 28),
        padding: EdgeInsets.symmetric(
          horizontal: StoycoScreenSize.width(context, 12),
          vertical: StoycoScreenSize.height(context, 4),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            StoycoScreenSize.width(context, 100),
          ),
          border: Border.all(color: ColorFoundation.text.fandom, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _selectedValue.label,
              style: TextStyle(
                fontFamily: StoycoFontFamilyToken.gilroy,
                fontWeight: FontWeight.bold,
                fontSize: StoycoScreenSize.width(context, 12),
                color: ColorFoundation.text.fandom,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(StoycoScreenSize.width(context, 6)),
            Icon(
              Icons.keyboard_arrow_down,
              size: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
            ),
          ],
        ),
      ),
    );
  }
}
