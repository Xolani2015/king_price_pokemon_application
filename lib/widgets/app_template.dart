import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/views/login/login_page.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_details_page.dart';
import 'package:king_price_pokemon_application/views/pokemonList/pokemon_list_page.dart';
import 'package:king_price_pokemon_application/widgets/app_bar.dart';
import 'package:king_price_pokemon_application/widgets/app_dialog.dart';
import 'package:provider/provider.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({
    super.key,
    required this.title,
    required this.page,
    required this.currentPage,
    this.isShowTopBar = false,
    this.hasMenu = false,
    this.hasBack = false,
    this.showFloatingActionButton = false,
  });

  final String title;
  final Widget page;
  final AppPage currentPage;
  final bool isShowTopBar;
  final bool hasMenu;
  final bool hasBack;
  final bool showFloatingActionButton;

  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: widget.isShowTopBar == true
          ? AppTopNavBar(
              hasMenu: widget.hasMenu,
              hasBack: widget.hasBack,
              logoPath: 'assets/branding/applogo.png',
              onMenuTap: null,
              onBackTap: () => _navigateToPage(widget.currentPage),
              onActionTap: () {},
            )
          : null,
      body: Padding(padding: AppSizes(context).padding.medium, child: widget.page),
      floatingActionButton: widget.showFloatingActionButton
          ? FloatingActionButton(
              onPressed: () {
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.toggleTheme();
              },
              backgroundColor: Theme.of(context).primaryColor,
              tooltip: 'Increment',
              child: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: AppColors.darkText),
            )
          : null,
    );
  }

  void _navigateToPage(AppPage page) {
    if (page == AppPage.pokemonList) {
      showDialog(
        context: context,
        builder: (context) => AppDialog(
          header: "Navigation",
          paragraph: "Are you want to logout ? ",
          sideIcon: Icons.warning,
        ),
      );
    } else if (page == AppPage.login) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PokemonListPage()));
    } else if (page == AppPage.registration) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else if (page == AppPage.pokemonDetail) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PokemonListPage()));
    } else if (page == AppPage.pokemonFavorites) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PokemonDetailPage()));
    }
  }
}
