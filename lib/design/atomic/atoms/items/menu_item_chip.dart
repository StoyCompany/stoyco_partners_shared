import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// {@template menu_item_chip}
/// A selectable chip-style menu item with active and inactive states.
///
/// This component is an **Atom** in the Atomic Design system, representing
/// a fundamental UI element for menu selections with distinct visual states.
///
/// The [MenuItemChip] displays differently based on its [isSelected] state:
///
/// **Active State (selected):**
/// * Width: 79px
/// * Background: Purple (#9E80E1)
/// * White text color
///
/// **Inactive State (unselected):**
/// * Width: 69px
/// * Transparent background
/// * Default text color
///
/// **Common Properties:**
/// * Height: 23px
/// * Border radius: 100px (fully rounded)
/// * Padding: 3px vertical, 10px horizontal
/// * Font: Gilroy Regular, 14px
/// * Line height: 100%
/// * Text alignment: Center
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to create a [MenuItemChip].
///
/// ```dart
/// MenuItemChip(
///   label: 'Pizza',
///   isSelected: true,
///   onTap: () {
///     print('Menu item tapped');
///   },
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CategoryItem], another selectable item component.
///  * [MenuCategories], a molecule that uses multiple category items.
class MenuItemChip extends StatelessWidget {
  /// {@macro menu_item_chip}
  ///
  /// Creates a [MenuItemChip] with the given parameters.
  ///
  /// The [label] argument must not be null.
  const MenuItemChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  /// The text displayed inside the chip.
  final String label;

  /// Whether this chip is currently selected.
  ///
  /// When true, displays with purple background and larger width.
  /// When false, displays with transparent background and smaller width.
  final bool isSelected;

  /// Called when the chip is tapped.
  ///
  /// If null, the chip will not respond to taps.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: isSelected ? 1 : 0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.scale(
            scale: 1.0 + (value * 0.08),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: StoycoScreenSize.width(context, 15),
                vertical: StoycoScreenSize.height(context, 3),
              ),
              decoration: BoxDecoration(
                color: Color.lerp(
                  Colors.transparent,
                  ColorFoundation.background.saHighlights,
                  value,
                ),
                borderRadius: BorderRadius.circular(
                  StoycoScreenSize.radius(context, 100),
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                    fontSize: StoycoScreenSize.fontSize(context, 14),
                    color: Color.lerp(
                      ColorFoundation.text.fandom,
                      ColorFoundation.text.saDark,
                      value,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
