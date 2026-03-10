import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

class ContentSwitchButton extends StatefulWidget {
  const ContentSwitchButton({
    super.key,
    this.value = false,
    this.onChanged,
    this.width,
    this.height,
    this.activeColor,
    this.inactiveColor,
    this.circleColor,
    this.duration = const Duration(milliseconds: 200),
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? width;
  final double? height;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? circleColor;
  final Duration duration;

  @override
  State<ContentSwitchButton> createState() => _ContentSwitchButtonState();
}

class _ContentSwitchButtonState extends State<ContentSwitchButton> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.value;
  }

  @override
  void didUpdateWidget(covariant ContentSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _isOn = widget.value;
    }
  }

  void _toggle() {
    setState(() {
      _isOn = !_isOn;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isOn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double circleSize =
        (widget.height ?? StoycoScreenSize.height(context, 32)) - 8;
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: widget.duration,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isOn
              ? (widget.activeColor ?? ColorFoundation.background.saHighlights)
              : (widget.inactiveColor ??
                    ColorFoundation.background.saHighlights),
          borderRadius: BorderRadius.circular(
            StoycoScreenSize.radius(context, 16),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              duration: widget.duration,
              left: _isOn
                  ? (widget.width ?? StoycoScreenSize.width(context, 56)) -
                        circleSize -
                        4
                  : 4,
              top: 4,
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  color:
                      widget.circleColor ?? ColorFoundation.background.saDark,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
