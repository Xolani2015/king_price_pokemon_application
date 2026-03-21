import 'package:flutter/material.dart';

class AppSizes {
  final BuildContext context;

  AppSizes(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  AppPadding get padding => AppPadding(width);
  AppFont get font => AppFont(width);
  AppSpace get space => AppSpace(width);
}

class AppPadding {
  final double width;

  AppPadding(this.width);

  EdgeInsets get small => EdgeInsets.all(width * 0.02);
  EdgeInsets get medium => EdgeInsets.all(width * 0.04);
  EdgeInsets get large => EdgeInsets.all(width * 0.06);
}

class AppFont {
  final double width;

  AppFont(this.width);

  double get small => width * 0.045;
  double get medium => width * 0.04;
  double get large => width * 0.05;
}

class AppSpace {
  final double width;

  AppSpace(this.width);

  SizedBox get small => SizedBox(height: width * 0.02);
  SizedBox get medium => SizedBox(height: width * 0.04);
  SizedBox get large => SizedBox(height: width * 0.06);
}
