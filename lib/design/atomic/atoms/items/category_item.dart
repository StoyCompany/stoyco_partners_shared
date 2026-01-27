import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/colors.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.colorSelector,
    required this.colorUnselected,
    required this.name,
    this.isSelected = false,
  });

  final Color colorSelector;
  final Color colorUnselected;
  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StoycoScreenSize.fromLTRB(
        context,
        right: 12,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: StoycoScreenSize.width(context, 12),
            height: StoycoScreenSize.width(context, 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? colorSelector : Colors.transparent,
              border: isSelected
                  ? null
                  : Border.all(
                      color: colorUnselected,
                      width: 3,
                    ),
            ),
          ),
          Gap(StoycoScreenSize.width(context, 10)),
          Text(
            name,
            style: TextStyle(
              fontSize: StoycoScreenSize.fontSize(context, 15),
              fontWeight: FontWeight.w400,
              color: isSelected ? StoycoColorsToken.saLightMenu : StoycoColorsToken.saTextDisabled,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        ],
      ),
    );
  }
}
