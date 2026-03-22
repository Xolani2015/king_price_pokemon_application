import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/widgets/app_partial_swip_card.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';

class PokemonFavouritesPage extends StatelessWidget {
  const PokemonFavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

    return Consumer<PokemonStore>(
      builder: (context, store, child) => AppTemplate(
        title: 'Pokemon Favourites',
        isShowTopBar: true,
        hasBack: true,
        showFloatingActionButton: true,
        currentPage: AppPage.pokemonFavorites,
        page: store.favourites.isEmpty
            ? const Center(child: Text('No favourites yet'))
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: store.favourites.length,
                itemBuilder: (context, index) {
                  final PokemonModel pokemon = store.favourites[index];
                  return AppPartialSwipCard(pokemon: pokemon);
                },
              ),
      ),
    );
  }
}
