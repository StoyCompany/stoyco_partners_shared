import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/table/experience_detail_table.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';
import 'package:stoyco_partners_shared/design/models/experience_detail_dto.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// A modal dialog widget that displays experience details in a table format.
///
/// This modal follows the same design pattern as [CustomModal] but replaces
/// the description text with a customizable table widget for displaying
/// structured information.
///
/// Example usage:
/// ```dart
/// Get.dialog<void>(ExperienceDetailModal(
///   data: ExperienceDetailDto(
///     eventName: 'Concert',
///     eventDate: DateTime(2024, 12, 31),
///     soldRows: [...],
///     availableRows: [...],
///     soldUnits: 50,
///     soldValue: 7500000,
///     currency: 'COP',
///   ),
///   closeAction: () => Navigator.pop(context),
/// ));
/// ```
class ExperienceDetailModal extends StatelessWidget {
  /// Creates an experience detail modal dialog.
  const ExperienceDetailModal({
    super.key,
    required this.data,
    this.closeActionLabel,
    this.closeAction,
    this.icon,
  });

  /// The data transfer object containing all experience detail information
  final ExperienceDetailDto data;

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
    final double verticalPadding = context.layout.value(xs: 18, md: 20, lg: 22);
    final double horizontalPadding = context.layout.value(
      xs: 18,
      md: 20,
      lg: 22,
    );

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: StoycoScreenSize.all(context, 18),
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
                          '${data.eventName} \n ${DatesFormats.formatDateDDMMYYYY(data.eventDate)}',
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontSize: StoycoScreenSize.fontSize(context, 16),
                            fontWeight: FontWeight.w500,
                            color: ColorFoundation.text.saDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ExperienceDetailTable(rows: data.soldRows),
                        Container(
                          padding: StoycoScreenSize.symmetric(
                            context,
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorFoundation.background.saDark,
                            borderRadius: BorderRadius.circular(
                              StoycoScreenSize.radius(context, 100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Vendidas ${data.soldUnits} UDS',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    12,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saLight,
                                ),
                              ),
                              Container(
                                padding: StoycoScreenSize.symmetric(
                                  context,
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      ColorFoundation.background.saHighlights,
                                  borderRadius: BorderRadius.circular(
                                    StoycoScreenSize.radius(context, 100),
                                  ),
                                ),
                                child: Text(
                                  '\$${data.soldValue ?? '0'} ${data.currency}',
                                  style: TextStyle(
                                    fontFamily: StoycoFontFamilyToken.gilroy,
                                    fontSize: StoycoScreenSize.fontSize(
                                      context,
                                      8,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: ColorFoundation.text.saDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExperienceDetailTable(rows: data.availableRows),
                        Container(
                          padding: StoycoScreenSize.symmetric(
                            context,
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorFoundation.background.saDark,
                            borderRadius: BorderRadius.circular(
                              StoycoScreenSize.radius(context, 100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Disponibles ${data.availableUnits} UDS',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    12,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saLight,
                                ),
                              ),
                              Container(
                                padding: StoycoScreenSize.symmetric(
                                  context,
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      ColorFoundation.background.saHighlights,
                                  borderRadius: BorderRadius.circular(
                                    StoycoScreenSize.radius(context, 100),
                                  ),
                                ),
                                child: Text(
                                  '\$${data.availableValue ?? '0'} ${data.currency}',
                                  style: TextStyle(
                                    fontFamily: StoycoFontFamilyToken.gilroy,
                                    fontSize: StoycoScreenSize.fontSize(
                                      context,
                                      8,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: ColorFoundation.text.saDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: StoycoScreenSize.symmetric(
                            context,
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorFoundation.background.saDark,
                            borderRadius: BorderRadius.circular(
                              StoycoScreenSize.radius(context, 100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Total ${data.totalUnits} UDS',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    12,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saLight,
                                ),
                              ),
                              Container(
                                padding: StoycoScreenSize.symmetric(
                                  context,
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      ColorFoundation.background.saHighlights,
                                  borderRadius: BorderRadius.circular(
                                    StoycoScreenSize.radius(context, 100),
                                  ),
                                ),
                                child: Text(
                                  '\$${data.totalValue ?? '0'} ${data.currency}',
                                  style: TextStyle(
                                    fontFamily: StoycoFontFamilyToken.gilroy,
                                    fontSize: StoycoScreenSize.fontSize(
                                      context,
                                      8,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: ColorFoundation.text.saDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 15),
                          fontWeight: FontWeight.w600,
                          color: ColorFoundation.text.saError,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
