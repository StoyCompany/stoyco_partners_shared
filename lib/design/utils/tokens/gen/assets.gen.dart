// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $LibGen {
  const $LibGen();

  /// Directory path: lib/assets
  $LibAssetsGen get assets => const $LibAssetsGen();
}

class $LibAssetsGen {
  const $LibAssetsGen();

  /// Directory path: lib/assets/colors
  $LibAssetsColorsGen get colors => const $LibAssetsColorsGen();

  /// Directory path: lib/assets/icons
  $LibAssetsIconsGen get icons => const $LibAssetsIconsGen();

  /// Directory path: lib/assets/images
  $LibAssetsImagesGen get images => const $LibAssetsImagesGen();
}

class $LibAssetsColorsGen {
  const $LibAssetsColorsGen();

  /// File path: lib/assets/colors/colors.xml
  String get colors => 'lib/assets/colors/colors.xml';

  /// List of all assets
  List<String> get values => [colors];
}

class $LibAssetsIconsGen {
  const $LibAssetsIconsGen();

  /// File path: lib/assets/icons/alert.svg
  SvgGenImage get alert => const SvgGenImage('lib/assets/icons/alert.svg');

  /// Directory path: lib/assets/icons/common
  $LibAssetsIconsCommonGen get common => const $LibAssetsIconsCommonGen();

  /// File path: lib/assets/icons/error.svg
  SvgGenImage get error => const SvgGenImage('lib/assets/icons/error.svg');

  /// File path: lib/assets/icons/error_x.svg
  SvgGenImage get errorX => const SvgGenImage('lib/assets/icons/error_x.svg');

  /// File path: lib/assets/icons/left_arrow.svg
  SvgGenImage get leftArrow =>
      const SvgGenImage('lib/assets/icons/left_arrow.svg');

  /// File path: lib/assets/icons/like.svg
  SvgGenImage get like => const SvgGenImage('lib/assets/icons/like.svg');

  /// File path: lib/assets/icons/mail_box.svg
  SvgGenImage get mailBox => const SvgGenImage('lib/assets/icons/mail_box.svg');

  /// File path: lib/assets/icons/share.svg
  SvgGenImage get share => const SvgGenImage('lib/assets/icons/share.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    alert,
    error,
    errorX,
    leftArrow,
    like,
    mailBox,
    share,
  ];
}

class $LibAssetsImagesGen {
  const $LibAssetsImagesGen();

  /// File path: lib/assets/images/stoyco_logo_white.png
  AssetGenImage get stoycoLogoWhite =>
      const AssetGenImage('lib/assets/images/stoyco_logo_white.png');

  /// File path: lib/assets/images/stoyco_onboarding_logo.png
  AssetGenImage get stoycoOnboardingLogo =>
      const AssetGenImage('lib/assets/images/stoyco_onboarding_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [stoycoLogoWhite, stoycoOnboardingLogo];
}

class $LibAssetsIconsCommonGen {
  const $LibAssetsIconsCommonGen();

  /// File path: lib/assets/icons/common/interrogation.svg
  SvgGenImage get interrogation =>
      const SvgGenImage('lib/assets/icons/common/interrogation.svg');

  /// File path: lib/assets/icons/common/stoyco.svg
  SvgGenImage get stoyco =>
      const SvgGenImage('lib/assets/icons/common/stoyco.svg');

  /// List of all assets
  List<SvgGenImage> get values => [interrogation, stoyco];
}

class StoycoAssetsToken {
  const StoycoAssetsToken._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
