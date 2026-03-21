import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

Flushbar showSuccessToast(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 4),
}) {
  return Flushbar<void>(
    title: 'Success',
    titleSize: AppSizes(context).font.large,
    messageSize: AppSizes(context).font.medium,
    message: message,
    duration: duration,
    backgroundColor: AppColors.successToast,
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}

Flushbar showErrorToast(BuildContext context, String message, {Duration? duration}) {
  return Flushbar<void>(
    title: 'Error',
    titleSize: AppSizes(context).font.large,
    messageSize: AppSizes(context).font.medium,
    message: message,
    duration: duration ?? const Duration(seconds: 4),
    backgroundColor: AppColors.errorToast,
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}
