import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppDataBar extends StatelessWidget {
  final String label;
  final int? value;

  const AppDataBar({super.key, required this.label, this.value});

  IconData _getIcon() {
    switch (label.toLowerCase()) {
      case "attack":
        return Icons.flash_on;
      case "defense":
        return Icons.shield;
      case "speed":
        return Icons.speed;
      case "hp":
        return Icons.favorite;
      default:
        return Icons.bar_chart;
    }
  }

  Color _getColor() {
    switch (label.toLowerCase()) {
      case "attack":
        return Colors.orange;
      case "defense":
        return Colors.blue;
      case "speed":
        return Colors.green;
      case "hp":
        return Colors.red;
      default:
        return AppColors.textInputBorderBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final safeValue = value ?? 0;
    final progress = (safeValue / 150).clamp(0.0, 1.0);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: kIsWeb
            ? AppSizes(context).space.height * 0.012
            : AppSizes(context).space.height * 0.001,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes(context).space.height * 0.05,
        vertical: AppSizes(context).space.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkSearchTextAndBorder : AppColors.searchTextAndBorder,
            blurRadius: kIsWeb ? 6 : 1,
            offset: Offset(0, kIsWeb ? 3 : 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(_getIcon(), color: _getColor(), size: 20),
          SizedBox(width: AppSizes(context).space.height * 0.015),

          SizedBox(
            width: kIsWeb
                ? AppSizes(context).space.height * 0.10
                : AppSizes(context).space.height * 0.08,
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                letterSpacing: 1.1,
              ),
            ),
          ),

          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_getColor().withOpacity(0.7), _getColor()],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(width: AppSizes(context).space.height * 0.03),

          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: safeValue),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Text(
                value.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: _getColor()),
              );
            },
          ),
        ],
      ),
    );
  }
}
