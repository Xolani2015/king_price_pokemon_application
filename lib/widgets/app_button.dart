import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final Color? backgroundColor;
  final bool isSecondaryButton;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 50,
    this.backgroundColor,
    this.isSecondaryButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color.fromARGB(255, 189, 25, 13);
    final appSizes = AppSizes(context);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSecondaryButton ? Colors.white : (backgroundColor ?? primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: isSecondaryButton ? BorderSide(color: primaryColor, width: 2) : BorderSide.none,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isSecondaryButton ? primaryColor : Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: isSecondaryButton ? primaryColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: appSizes.font.small,
                ),
              ),
      ),
    );
  }
}
