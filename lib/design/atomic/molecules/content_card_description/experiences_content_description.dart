import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/experience_stat.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Gutter.separateChildren(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Gutter.separateChildren(
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      color: ColorFoundation.text.saLight,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ExperienceContentStat(
                    statLabel: 'UDS Totales',
                    statValue: data.totalTickets,
                    statRevenue: data.totalRevenue,
                    statCurrency: data.currency,
                    labelTooltipMessage:
                        'Capacidad total de boletos configurados para esta experiencia.',
                    revenueTooltipMessage:
                        'Valor máximo estimado si se venden todos los boletos.',
                  ),
                  ExperienceContentStat(
                    statLabel: 'UDS Disponibles',
                    statValue: data.availableTickets,
                    statRevenue: data.availableRevenue,
                    statCurrency: data.currency,
                    labelTooltipMessage:
                        'Boletos que aún están disponibles para la venta.',
                    revenueTooltipMessage:
                        'Ingreso potencial pendiente si se venden los boletos disponibles.',
                  ),
                  ExperienceContentStat(
                    statLabel: 'UDS Vendidas',
                    statValue: data.soldTickets,
                    statRevenue: data.soldRevenue,
                    statCurrency: data.currency,
                    labelTooltipMessage:
                        'Total de boletos vendidos para esta experiencia.',
                    revenueTooltipMessage:
                        'Ingresos generados por la venta de boletos.',
                  ),
                ],
                extent: StoycoScreenSize.height(context, 5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  data.isActive
                      ? 'Fecha de evento ${data.eventDate}'
                      : 'Finalizado  ${data.eventDate}',
                  style: TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontSize: StoycoScreenSize.fontSize(context, 8),
                    color: ColorFoundation.text.saLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
