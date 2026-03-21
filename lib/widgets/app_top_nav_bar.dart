import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

class AppTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;
  final String logoPath;
  final IconData actionIcon;

  const AppTopNavBar({
    super.key,
    required this.isHomePage,
    this.title,
    this.onMenuTap,
    this.onBackTap,
    this.onActionTap,
    required this.logoPath,
    this.actionIcon = Icons.more_vert,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: sizes.height * 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (isHomePage)
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: isDark ? AppColors.darkIcon : AppColors.icon,
                          ),
                          onPressed: onMenuTap,
                        )
                      else
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: onBackTap ?? () => Navigator.pop(context),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(logoPath, height: sizes.height * 0.05),
                      if (!isHomePage) ...[
                        sizes.space.small,
                        Text(
                          title ?? '',
                          style: TextStyle(
                            fontSize: sizes.font.medium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  IconButton(
                    icon: Icon(actionIcon, color: isDark ? AppColors.darkIcon : AppColors.icon),
                    onPressed: onActionTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
