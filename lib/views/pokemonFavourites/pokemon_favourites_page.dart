import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/widgets/app_partial_swip_card.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PokemonFavouritesPage extends StatelessWidget {
  const PokemonFavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer<PokemonStore>(
      builder: (context, store, child) => AppTemplate(
        title: 'Pokemon Favourites',
        isShowTopBar: true,
        hasBack: true,
        showFloatingActionButton: true,
        currentPage: AppPage.pokemonFavorites,
        page: store.favourites.isEmpty
            ? Column(
                children: [
                  const Center(child: Text('No favourites yet')),
                  SizedBox(height: sizes.height * 0.03),
                  Text(
                    'Go to details page to add pokemons',
                    style: TextStyle(
                      fontSize: AppSizes(context).font.large * 0.5,
                      color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: AppSizes(context).font.large,
                      color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sizes.height * 0.03),
                  Text(
                    'Swipe Card LEFT to remove Pokemon',
                    style: TextStyle(
                      fontSize: AppSizes(context).font.large * 0.5,
                      color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: sizes.height * 0.5,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: store.favourites.length,
                      itemBuilder: (context, index) {
                        final PokemonModel pokemon = store.favourites[index];
                        return AppPartialSwipCard(pokemon: pokemon);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
