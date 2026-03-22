import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/views/pokemonFavourites/pokemon_favourites_viewmodel.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';

class PokemonFavouritesPage extends StatefulWidget {
  const PokemonFavouritesPage({super.key});

  @override
  State<PokemonFavouritesPage> createState() => _PokemonFavouritesPageState();
}

class _PokemonFavouritesPageState extends State<PokemonFavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonFavouritesViewmodel(),
      child: Consumer<PokemonFavouritesViewmodel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'Pokemon Favourites',
          currentPage: AppPage.pokemonFavorites,
          page: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ],
            ),
          ),
        ),
      ),
    );
  }
}
