import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final bool isSecondaryButton;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 65,
    this.isSecondaryButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: Size(double.infinity, height), // enforce height
      backgroundColor: isSecondaryButton
          ? (isDark
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).scaffoldBackgroundColor)
          : (isDark ? AppColors.darkPrimaryButtonBackground : AppColors.primaryButtonBackground),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: isSecondaryButton
          ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
          : BorderSide.none,
    );

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (!isLoading) ? onPressed : null,
        style: buttonStyle,
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isSecondaryButton ? Theme.of(context).primaryColor : Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: isSecondaryButton ? Theme.of(context).primaryColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: appSizes.font.medium,
                ),
              ),
      ),
    );
  }
}
