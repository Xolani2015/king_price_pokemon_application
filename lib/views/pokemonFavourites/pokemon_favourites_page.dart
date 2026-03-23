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
        page: Column(
          children: [
            Text(
              'Pokemon Favourites',
              style: TextStyle(
                fontSize: kIsWeb
                    ? AppSizes(context).font.large * 1.2
                    : AppSizes(context).font.large,
                color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: sizes.height * 0.03),
            Text(
              store.favourites.isNotEmpty
                  ? 'Swipe the card LEFT to remove pokemon'
                  : 'Go to details page to add favourites',
              style: TextStyle(
                fontSize: kIsWeb
                    ? AppSizes(context).font.large * 1.2
                    : AppSizes(context).font.large,
                color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            store.favourites.isEmpty
                ? const Center(child: Text('No favourites yet'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: store.favourites.length,
                    itemBuilder: (context, index) {
                      final PokemonModel pokemon = store.favourites[index];
                      return AppPartialSwipCard(pokemon: pokemon);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
