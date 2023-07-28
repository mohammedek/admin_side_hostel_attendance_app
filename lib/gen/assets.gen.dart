/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/lottie_already_exists.json
  String get lottieAlreadyExists => 'assets/lottie/lottie_already_exists.json';

  /// File path: assets/lottie/lottie_no_internet.json
  String get lottieNoInternet => 'assets/lottie/lottie_no_internet.json';

  /// File path: assets/lottie/lottie_no_internet1.json
  String get lottieNoInternet1 => 'assets/lottie/lottie_no_internet1.json';

  /// File path: assets/lottie/lottie_splash.json
  String get lottieSplash => 'assets/lottie/lottie_splash.json';

  /// List of all assets
  List<String> get values =>
      [lottieAlreadyExists, lottieNoInternet, lottieNoInternet1, lottieSplash];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/wmo_logo.png
  AssetGenImage get wmoLogo => const AssetGenImage('assets/svg/wmo_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [wmoLogo];
}

class Assets {
  Assets._();

  static const AssetGenImage backgroundImage2 =
      AssetGenImage('assets/background_image_2.jpg');
  static const AssetGenImage breakfast = AssetGenImage('assets/breakfast.jpg');
  static const AssetGenImage dinner = AssetGenImage('assets/dinner.png');
  static const AssetGenImage hostelFull =
      AssetGenImage('assets/hostel_full.jpeg');
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const AssetGenImage lunch = AssetGenImage('assets/lunch.png');
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const AssetGenImage tick = AssetGenImage('assets/tick.png');
  static const AssetGenImage wantAll = AssetGenImage('assets/want_all.jpg');
  static const AssetGenImage wmoLogo = AssetGenImage('assets/wmo_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        backgroundImage2,
        breakfast,
        dinner,
        hostelFull,
        lunch,
        tick,
        wantAll,
        wmoLogo
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
