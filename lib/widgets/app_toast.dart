import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void showSuccessToast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColors.successToast,
    textColor: Colors.white,
    fontSize: kIsWeb ? AppSizes(context).font.small : AppSizes(context).font.large * 0.5,
  );
}

void showErrorToast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColors.errorToast,
    textColor: Colors.black,
    fontSize: kIsWeb ? AppSizes(context).font.small : AppSizes(context).font.large * 0.5,
  );
}
