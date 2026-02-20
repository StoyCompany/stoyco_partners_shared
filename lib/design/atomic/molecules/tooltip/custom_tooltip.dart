import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// Position of the tooltip relative to the child widget
enum TooltipPosition {
  /// Display tooltip above the child widget
  top,
  
  /// Display tooltip below the child widget
  bottom,
  
  /// Display tooltip to the left of the child widget
  left,
  
  /// Display tooltip to the right of the child widget
  right,
}

/// A customizable tooltip molecule that displays contextual information
/// when tapped on a child widget.
/// 
/// This molecule follows the Atomic Design pattern and provides flexible
/// positioning, styling, and behavior options. The tooltip appears as an
/// overlay with an optional close button and can be positioned in any of
/// four directions relative to the child widget.
/// 
/// **Atomic Design Pattern**: Molecule
/// 
/// **Example usage**:
/// ```dart
/// CustomTooltip(
///   message: 'Total likes for this content',
///   position: TooltipPosition.top,
///   margin: 8,
///   child: Icon(Icons.favorite),
/// )
/// ```
class CustomTooltip extends StatefulWidget {
  const CustomTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = TooltipPosition.top,
    this.backgroundColor,
    this.textColor,
    this.maxWidth,
    this.padding,
    this.margin = 8.0,
    this.borderRadius,
    this.showCloseButton = true,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overlayColor,
  });

  /// The text message to display in the tooltip
  final String message;

  /// The widget that triggers the tooltip on tap
  final Widget child;

  /// Position of the tooltip relative to the child
  final TooltipPosition position;

  /// Background color of the tooltip container
  final Color? backgroundColor;

  /// Text color of the tooltip message
  final Color? textColor;

  /// Maximum width constraint for the tooltip
  final double? maxWidth;

  /// Padding inside the tooltip container
  final EdgeInsets? padding;

  /// Spacing between the child widget and the tooltip (in logical pixels)
  final double margin;

  /// Border radius of the tooltip container
  final BorderRadius? borderRadius;

  /// Whether to show the close button inside the tooltip
  final bool showCloseButton;

  /// Font size of the tooltip text
  final double? fontSize;

  /// Font weight of the tooltip text
  final FontWeight? fontWeight;

  /// Text alignment within the tooltip
  final TextAlign? textAlign;

  /// Maximum number of lines for the tooltip text
  final int? maxLines;

  /// Background color of the overlay (dimmed screen behind tooltip)
  final Color? overlayColor;

  @override
  State<CustomTooltip> createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  /// Overlay entry for displaying the tooltip
  OverlayEntry? _overlayEntry;
  
  /// Layer link for positioning the tooltip relative to the child
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  /// Removes the tooltip overlay from the screen
  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Shows the tooltip overlay when the child widget is tapped
  void _showTooltip() {
    // Prevent showing multiple tooltips at once
    if (_overlayEntry != null) {
      return;
    }

    // Create and insert the overlay entry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _removeTooltip,
        child: Material(
          color: widget.overlayColor ?? Colors.black.withOpacity(0.5),
          child: Stack(
            children: <Widget>[
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: _getTargetAnchor(),
                followerAnchor: _getFollowerAnchor(),
                offset: _getOffset(),
                child: _buildTooltipContent(context),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Defines the anchor point on the child widget where the tooltip connects
  Alignment _getTargetAnchor() {
    switch (widget.position) {
      case TooltipPosition.top: 
        return Alignment.topCenter;
      case TooltipPosition.bottom: 
        return Alignment.bottomCenter;
      case TooltipPosition.left: 
        return Alignment.centerLeft;
      case TooltipPosition.right: 
        return Alignment.centerRight;
    }
  }

  /// Defines which point of the tooltip connects to the child's anchor
  Alignment _getFollowerAnchor() {
    switch (widget.position) {
      case TooltipPosition.top: 
        return Alignment.bottomCenter;
      case TooltipPosition.bottom: 
        return Alignment.topCenter;
      case TooltipPosition.left: 
        return Alignment.centerRight;
      case TooltipPosition.right: 
        return Alignment.centerLeft;
    }
  }

  /// Applies the margin offset to position the tooltip away from the child
  Offset _getOffset() {
    switch (widget.position) {
      case TooltipPosition.top: 
        return Offset(0, -widget.margin);
      case TooltipPosition.bottom: 
        return Offset(0, widget.margin);
      case TooltipPosition.left: 
        return Offset(-widget.margin, 0);
      case TooltipPosition.right: 
        return Offset(widget.margin, 0);
    }
  }

  /// Builds the tooltip content container with message and optional close button
  Widget _buildTooltipContent(BuildContext context) {
    final Color bgColor = widget.backgroundColor ?? ColorFoundation.background.saLight;
    final Color contentColor = widget.textColor ?? ColorFoundation.text.saDark;
    
    return IntrinsicWidth(
      child: Container(
        padding: widget.padding ?? EdgeInsets.symmetric(
          horizontal: StoycoScreenSize.width(context, 12),
          vertical: StoycoScreenSize.height(context, 8),
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(
            StoycoScreenSize.width(context, 5),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? StoycoScreenSize.width(context, 180),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.showCloseButton) ...<Widget>[
              GestureDetector(
                onTap: _removeTooltip,
                child: Container(
                  padding: EdgeInsets.all(
                    StoycoScreenSize.width(context, 4),
                  ),
                  child: Icon(
                    Icons.close,
                    size: StoycoScreenSize.width(context, 12),
                    color: contentColor,
                  ),
                ),
              ),
              Gutter(StoycoScreenSize.width(context, 10)),
            ],
            Flexible(
              child: Text(
                widget.message,
                textAlign: widget.textAlign ?? TextAlign.start,
                maxLines: widget.maxLines ?? 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: StoycoFontFamilyToken.gilroy,
                  fontSize: widget.fontSize ?? StoycoScreenSize.fontSize(context, 10),
                  fontWeight: widget.fontWeight ?? FontWeight.w500,
                  color: contentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _showTooltip,
        child: widget.child,
      ),
    );
  }
}
