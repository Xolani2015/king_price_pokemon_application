import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/widgets/app_top_nav_bar.dart';
import 'package:provider/provider.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({
    super.key,
    required this.title,
    required this.page,
    this.isShowTopBar = false,
  });

  final String title;
  final Widget page;
  final bool isShowTopBar;
  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isShowTopBar == true
          ? AppTopNavBar(
              isHomePage: true,
              logoPath: 'assets/branding/app_logo.webp',
              onMenuTap: () {},
              onActionTap: () {},
            )
          : null,
      body: Padding(padding: AppSizes(context).padding.medium, child: widget.page),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
          themeProvider.toggleTheme();
        },
        backgroundColor: Theme.of(context).primaryColor,

        tooltip: 'Increment',
        child: Icon(Icons.add, color: AppColors.darkText),
      ),
    );
  }
}
