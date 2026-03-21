import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';


class AppCustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;
  final String logoPath;
  final IconData actionIcon;

  const AppCustomTopBar({
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: sizes.padding.medium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (isHomePage)
                  IconButton(
                    icon: const Icon(Icons.menu),
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
                Image.asset(
                  logoPath,
                  height: sizes.height * 0.04,
                ),
                if (!isHomePage) ...[
                  sizes.space.small,
                  Text(
                    title ?? '',
                    style: TextStyle(
                      fontSize: sizes.font.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]
              ],
            ),
            IconButton(
              icon: Icon(actionIcon),
              onPressed: onActionTap,
            ),
          ],
        ),
      ),
    );
  }
}