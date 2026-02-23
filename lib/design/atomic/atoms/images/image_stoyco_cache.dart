import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/skeletons/skeleton_card.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/logs/logger.dart';

class ImageStoycoCache extends StatelessWidget {
  const ImageStoycoCache({
    super.key,
    required this.imageUrl,
    this.height = 115,
    this.width,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.useOldImageOnUrlChange = true,
    this.backgroundColor,
  });

  final String imageUrl;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useOldImageOnUrlChange;
  final Color? backgroundColor; 

  @override
  Widget build(BuildContext context) {
    final BorderRadius adaptiveBorderRadius = borderRadius ?? BorderRadius.circular(
      StoycoScreenSize.radius(context, 5),
    );
    final double adaptiveHeight = StoycoScreenSize.width(context, height);
    final double? adaptiveWidth = width != null ? StoycoScreenSize.width(context, width!) : null;
    final String normalizedUrl = _normalizeUrl(imageUrl);

    final Widget imageWidget = ClipRRect(
      borderRadius: adaptiveBorderRadius,
      child: CachedNetworkImage(
        imageUrl: normalizedUrl,
        height: adaptiveHeight,
        width: adaptiveWidth ?? double.infinity,
        fit: fit,
        useOldImageOnUrlChange: useOldImageOnUrlChange,
        memCacheHeight: adaptiveHeight.toInt() * 2,
        memCacheWidth: adaptiveWidth?.toInt() != null ? adaptiveWidth!.toInt() * 2 : null,
        placeholder: (BuildContext context, String url) {
          return placeholder ?? _buildDefaultPlaceholder(
            adaptiveHeight, 
            adaptiveWidth, 
            adaptiveBorderRadius,
          );
        }, 
        errorWidget: (BuildContext context, String url, Object error) {
          StoyCoLogger.error('Error loading image: $url, error: $error');
          return errorWidget ?? _buildDefaultError(
            adaptiveHeight, 
            adaptiveWidth,
          );
        },
      ),
    );

    if (backgroundColor != null) {
      return Stack(
        children: <Widget>[
          Container(
            height: adaptiveHeight,
            width: adaptiveWidth ?? double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: adaptiveBorderRadius,
            ),
          ),
          imageWidget,
        ],
      );
    }

    return imageWidget;
  }

  String _normalizeUrl(String url) {
    if (url.isEmpty) {
      return url;
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return 'https://$url';
  }

  Widget _buildDefaultPlaceholder(double h, double? w, BorderRadius r) {
    return SkeletonCard(
      height: h,
      width: w ?? double.infinity,
      borderRadius: r,
    );
  }

  Widget _buildDefaultError(double h, double? w) {
    return Container(
      height: h,
      width: w ?? double.infinity,
      color: ColorFoundation.text.black_1,
      child: Icon(
        Icons.broken_image_rounded,
        color: ColorFoundation.text.saHighlights,
        size: h * 0.3,
      ),
    );
  }
}
