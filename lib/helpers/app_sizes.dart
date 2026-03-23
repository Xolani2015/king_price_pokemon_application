import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppSizes {
  final BuildContext context;

  AppSizes(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  AppPadding get padding => AppPadding(height);
  AppFont get font => AppFont(height);
  AppSpace get space => AppSpace(height);
}

class AppPadding {
  final double height;

  AppPadding(this.height);

  double get small => kIsWeb ? height * 0.03 : height * 0.02;
  double get medium => kIsWeb ? height * 0.06 : height * 0.04;
  double get large => kIsWeb ? height * 0.1 : height * 0.06;
}

class AppFont {
  final double height;

  AppFont(this.height);

  double get small => kIsWeb ? height * 0.02 : height * 0.0;
  double get medium => kIsWeb ? height * 0.02 : height * 0.02;
  double get large => kIsWeb ? height * 0.04 : height * 0.04;
  double get xlarge => kIsWeb ? height * 0.12 : height * 0.06;
  double get xxlarge => kIsWeb ? height * 0.18 : height * 0.08;
  double get xxxlarge => kIsWeb ? height * 0.25 : height * 0.1;
  double get jumbo => kIsWeb ? height * 0.35 : height * 0.12;
}

class AppSpace {
  final double height;

  AppSpace(this.height);
  double get xxsmall => kIsWeb ? height * 0.04 : height * 0.03;
  double get xsmall => kIsWeb ? height * 0.06 : height * 0.04;
  double get small => kIsWeb ? height * 0.08 : height * 0.06;
  double get medium => kIsWeb ? height * 0.1 : height * 0.08;
  double get large => kIsWeb ? height * 0.2 : height * 0.1;
  double get xlarge => kIsWeb ? height * 0.3 : height * 0.2;
  double get xxlarge => kIsWeb ? height * 0.4 : height * 0.25;
  double get xxxlarge => kIsWeb ? height * 0.5 : height * 0.4;
  double get jumbo => kIsWeb ? height * 0.6 : height * 0.9;
}
