import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';

class AppTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasMenu;
  final bool hasBack;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;
  final String logoPath;
  final IconData actionIcon;

  const AppTopNavBar({
    super.key,
    this.hasMenu = false,
    this.hasBack = false,
    this.title,
    this.onMenuTap,
    this.onBackTap,
    this.onActionTap,
    required this.logoPath,
    this.actionIcon = Icons.more_vert,
  });

  @override
  Size get preferredSize => const Size.fromHeight(90);

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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: hasBack
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isDark
                                ? AppColors.iconContinanerBackground
                                : AppColors.darkIconContinanerBackground,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: isDark ? AppColors.darkPrimaryIcon : AppColors.primaryIcon,
                            ),
                            onPressed: () => onBackTap?.call(),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Expanded(flex: 5, child: Image.asset(logoPath, height: sizes.height * 0.05)),
              Expanded(
                child: hasMenu
                    ? Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            actionIcon,
                            color: isDark ? AppColors.darkPrimaryIcon : AppColors.primaryIcon,
                          ),
                          onPressed: onActionTap ?? onMenuTap,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
