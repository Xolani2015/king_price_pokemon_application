import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_Details_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonFavourites/pokemon_favourites_page.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
import 'package:king_price_pokemon_application/widgets/app_data_bars.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:king_price_pokemon_application/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sizes = AppSizes(context);

    return Consumer<PokemonDetailsViewmodel>(
      builder: (context, vm, child) {
        final PokemonModel? pokemon = vm.pokemonDetails;

        return AppTemplate(
          title: pokemon?.name ?? 'Pokemon Details',
          currentPage: AppPage.pokemonDetail,
          isShowTopBar: true,
          hasBack: true,
          showFloatingActionButton: false,
          page: pokemon == null
              ? const Center(child: Text('No Pokemon selected'))
              : Consumer<PokemonStore>(
                  builder: (context, store, child) {
                    final isFav = store.isFavourite(pokemon);

                    final isWide = MediaQuery.of(context).size.width > 800;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kIsWeb ? AppSizes(context).padding.medium : 0,
                          vertical: kIsWeb ? AppSizes(context).padding.medium : 0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Pokemon Details',
                              style: TextStyle(
                                fontSize: kIsWeb
                                    ? AppSizes(context).font.large
                                    : AppSizes(context).font.large * 0.7,
                                color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: sizes.height * 0.03),
                            isWide
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: _leftPanel(context, pokemon, isFav, store, isDark),
                                      ),
                                      SizedBox(width: sizes.width * 0.05),
                                      Expanded(flex: 3, child: _rightPanel(context, pokemon)),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _leftPanel(context, pokemon, isFav, store, isDark),
                                      SizedBox(height: sizes.height * 0.03),
                                      _rightPanel(context, pokemon),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _leftPanel(
    BuildContext context,
    PokemonModel pokemon,
    bool isFav,
    PokemonStore store,
    bool isDark,
  ) {
    final sizes = AppSizes(context);

    return Column(
      children: [
        if (pokemon.image.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(
              pokemon.image,
              height: kIsWeb ? sizes.height * 0.25 : sizes.height * 0.15,
              fit: BoxFit.contain,
            ),
          ),
        SizedBox(height: sizes.height * 0.02),
        Text(
          pokemon.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kIsWeb ? sizes.font.large * 1.2 : sizes.font.large * 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: sizes.height * 0.02),
        if (isFav)
          Text(
            'In favourites',
            style: TextStyle(
              fontSize: sizes.font.medium,
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.thumb_up, color: isFav ? Colors.green : Colors.grey),
              onPressed: () {
                store.addFavourite(pokemon);
                showSuccessToast(context, 'Added to favourites');
              },
            ),
            IconButton(
              icon: Icon(Icons.thumb_down, color: isFav ? Colors.red : Colors.grey),
              onPressed: () {
                if (isFav) {
                  store.removeFavourite(pokemon);
                } else {
                  showErrorToast(context, '${pokemon.name} is not in favourites');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _rightPanel(BuildContext context, PokemonModel pokemon) {
    return Column(
      children: [
        AppDataBar(label: "HP", value: pokemon.hp),
        AppDataBar(label: "Attack", value: pokemon.attack),
        AppDataBar(label: "Defense", value: pokemon.defense),
        AppDataBar(label: "Speed", value: pokemon.speed),
        const SizedBox(height: 20),
        AppButton(
          text: 'See Favourites',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PokemonFavouritesPage()),
            );
          },
        ),
      ],
    );
  }
}
