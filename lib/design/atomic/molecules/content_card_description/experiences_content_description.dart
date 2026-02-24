import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/revenue_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/experiences_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ExperiencesContentDescription extends StatelessWidget {
  const ExperiencesContentDescription({
    super.key,
    required this.data,
    this.onTapDetail,
  });

  final ExperiencesContentModel data;
  final VoidCallback? onTapDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 125),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Gutter.separateChildren(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Gutter.separateChildren(
                children: <Widget>[
                  Text(
                    data.name.length > 42
                        ? '${data.name.substring(0, 42)}…'
                        : data.name,
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      color: ColorFoundation.text.saLight,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'UDS totales:',
                        data: data.totalTickets,
                        tooltipMessage:
                            'Capacidad total de boletos configurados para esta experiencia.',
                      ),
                      RevenueStat(
                        value: data.totalRevenue,
                        currency: data.currency,
                        tooltipMessage:
                            'Valor máximo estimado si se venden todos los boletos.',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'UDS disponibles:',
                        data: data.availableTickets,
                        tooltipMessage:
                            'Boletos que aún están disponibles para la venta.',
                      ),
                      RevenueStat(
                        value: data.availableRevenue,
                        currency: data.currency,
                        tooltipMessage:
                            'Ingreso potencial pendiente si se venden los boletos disponibles.',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'UDS vendidas:',
                        data: data.soldTickets,
                        tooltipMessage:
                            'Total de boletos vendidos para esta experiencia.',
                      ),
                      RevenueStat(
                        value: data.soldRevenue,
                        currency: data.currency,
                        tooltipMessage:
                            'Ingresos generados por la venta de boletos.',
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: GestureDetector(
                      onTap: onTapDetail,
                      child: Text(
                        'Ver detalle',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 10),
                          color: ColorFoundation.text.saLight,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorFoundation.text.saLight,
                        ),
                      ),
                    ),
                  ),
                ],
                extent: StoycoScreenSize.height(context, 5),
              ),
            ),
            Text(
              'Fecha de evento ${data.eventDate}',
              style: TextStyle(
                fontFamily: StoycoFontFamilyToken.gilroy,
                fontSize: StoycoScreenSize.fontSize(context, 8),
                color: ColorFoundation.text.saLight,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          extent: StoycoScreenSize.height(context, 5),
        ),
      ),
    );
  }
}
