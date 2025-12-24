import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/buttons/custom_button.dart';
import 'package:stoyco_partners_shared/design/layout.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({
    super.key,
    required this.title,
    required this.description,
    required this.cancelAction,
    required this.confirmAction,
  });

  final String title;
  final String description;
  final VoidCallback? cancelAction;
  final VoidCallback? confirmAction;

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = context.layout.value(xs: 32, md: 36, lg: 42);
    final double horizontalPadding = context.layout.value(
      xs: 28,
      md: 32,
      lg: 34,
    );

    return Container(
      decoration: BoxDecoration(
        color: ColorFoundation.background.saLight,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorFoundation.border.saDark, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Column(
              children: Gutter.separateChildren(
                children: [
                  StoycoAssetsToken.lib.assets.icons.error.svg(
                    package: 'stoyco_partners_shared',
                    height: 24,
                    width: 24,
                  ),
                  Text(title, style: FontFoundation.title.bold25saDark),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: FontFoundation.paragraph.medium16saDark,
                  ),
                ],
                extent: 20,
              ),
            ),
          ),
          Container(
            height: 65,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: ColorFoundation.border.saDark, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ModalButton(
                    onTap: cancelAction,
                    label: 'CANCELAR',
                    textStyle: FontFoundation.label.semiBold15saError,
                  ),
                ),
                Container(width: 1, color: ColorFoundation.border.saDark),
                Expanded(
                  child: _ModalButton(
                    onTap: confirmAction,
                    label: 'VOLVER A ENVIAR',
                    textStyle: FontFoundation.label.semiBold15saDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalButton extends StatelessWidget {
  const _ModalButton({
    required this.onTap,
    required this.label,
    required this.textStyle,
  });

  final VoidCallback? onTap;
  final String label;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(child: Text(label, style: textStyle)),
    );
  }
}
