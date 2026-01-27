import 'package:flutter/material.dart';

class _Accessibility {
  double textFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  double deviceRadio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  MediaQueryData data(BuildContext context) {
    return MediaQuery.of(context).copyWith(
      textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio.clamp(2.55, 3.5),
    );
  }
}

final _Accessibility accessibility = _Accessibility();
