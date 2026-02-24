import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// A modal dialog widget that displays experience details in a table format.
///
/// This modal follows the same design pattern as [CustomModal] but replaces
/// the description text with a customizable table widget for displaying
/// structured information.
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => ExperienceDetailModal(
///     title: 'Detalles de la Experiencia',
///     table: YourTableWidget(),
///     closeActionLabel: 'CERRAR',
///     closeAction: () => Navigator.pop(context),
///   ),
/// );
/// ```
class ExperienceDetailModal extends StatelessWidget {
  /// Creates an experience detail modal dialog.
  ///
  /// The [title] and [table] are required.
  /// The [table] widget should contain the structured information to display.
  const ExperienceDetailModal({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.table,
    this.closeActionLabel,
    this.closeAction,
    this.icon,
  });

  /// The title text displayed at the top of the modal.
  final String eventName;

  final DateTime eventDate;

  /// The table widget containing the experience details.
  final Widget table;

  /// The label for the close button.
  ///
  /// Defaults to 'CERRAR' if not provided.
  final String? closeActionLabel;

  /// The callback executed when the close button is tapped.
  final VoidCallback? closeAction;

  /// An optional icon widget displayed at the top of the modal.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = context.layout.value(xs: 32, md: 36, lg: 42);
    final double horizontalPadding = context.layout.value(
      xs: 28,
      md: 32,
      lg: 34,
    );

    return Center(
      child: Padding(
        padding: StoycoScreenSize.all(context, 20),
        child: Container(
          decoration: BoxDecoration(
            color: ColorFoundation.background.saLight,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  children: Gutter.separateChildren(
                    children: <Widget>[
                      if (icon != null) icon!,
                      Text(
                        'Detalle de evento',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 25),
                          fontWeight: FontWeight.w700,
                          color: ColorFoundation.text.saDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$eventName \n ${DatesFormats.formatDateDDMMYYYY(eventDate)}',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 16),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      table,
                    ],
                    extent: 12,
                  ),
                ),
              ),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ColorFoundation.border.saDark,
                      width: 1,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: closeAction,
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      closeActionLabel ?? 'CERRAR',
                      style: FontFoundation.label.semiBold15saDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
