import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/content_chip.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/merch_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class MerchContentDescription extends StatelessWidget {
  const MerchContentDescription({required this.data, super.key});

  final MerchContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.white,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    MessagedDescriptionTooltip(
                      message: 'Precio: ',
                      dataText: NumbersFormat.formatCurrency(
                        data.price,
                        currency: data.currency,
                      ),
                      tooltipMessage:
                          'Corresponde al precio de venta publicado.',
                    ),
                    MessagedDescriptionTooltip(
                      message: 'Costo: ',
                      dataText: NumbersFormat.formatCurrency(
                        data.cost,
                        currency: data.currency,
                      ),
                      tooltipMessage: 'Corresponde al costo unitario registrado.',
                    ),
                    _InfoRowWithChip(
                      message: 'UDS Vendidas: ',
                      data: data.unitsSold,
                      chipMessage: NumbersFormat.formatCurrency(
                        data.generatedRevenue,
                        currency: data.currency,
                      ),
                      tooltipMessage: 'Ingresos generados = Precio de venta x unidades vendidas.',
                    ),
                    _InfoRowWithChip(
                      message: 'UDS Disponibles: ',
                      data: data.unitsAvailable,
                      chipMessage: NumbersFormat.formatCurrency(
                        data.availableInventoryValue,
                        currency: data.currency,
                      ),
                      tooltipMessage: 'Valor del inventario disponible = Costo x unidades disponibles.',
                    ),
                    _InfoRowWithChip(
                      message: 'UDS Totales: ',
                      data: data.totalUnits,
                      chipMessage: NumbersFormat.formatCurrency(
                        data.totalInitialInventoryValue,
                        currency: data.currency,
                      ),
                      tooltipMessage: 'Valor total del inventario inicial = Costo x unidades totales.',
                    ),
                  ],
                  extent: StoycoScreenSize.height(context, 5),
                ),
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}

class _InfoRowWithChip extends StatelessWidget {
  const _InfoRowWithChip({
    required this.message,
    required this.data,
    required this.chipMessage,
    required this.tooltipMessage,
  });

  final String message;
  final int data;
  final String chipMessage;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        MessagedDescriptionTooltip(
          message: message,
          data: data,
          tooltipMessage: tooltipMessage,
        ),
        ContentChip(
          message: chipMessage,
          position: TooltipPosition.left,
          messageStyle: TextStyle(
            package: 'stoyco_partners_shared',
            fontSize: StoycoScreenSize.fontSize(context, 10),
            color: ColorFoundation.text.saDark,
            fontWeight: FontWeight.w500,
            fontFamily: StoycoFontFamilyToken.apercu,
          ),
          tooltipMessage: tooltipMessage,
          padding: StoycoScreenSize.symmetric(context, horizontal: 8),
        ),
      ],
    );
  }
}
