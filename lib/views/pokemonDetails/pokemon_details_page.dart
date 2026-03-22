import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_Details_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonFavourites/pokemon_favourites_page.dart';
import 'package:king_price_pokemon_application/widgets/app_button.dart';
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
          title: pokemon?.name ?? 'Pokémon Details',
          currentPage: AppPage.pokemonDetail,
          isShowTopBar: true,
          hasBack: true,
          showFloatingActionButton: true,
          page: pokemon == null
              ? const Center(child: Text('No Pokémon selected'))
              : Consumer<PokemonStore>(
                  builder: (context, store, child) {
                    final isFav = store.isFavourite(pokemon);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Pokemon Details',
                            style: TextStyle(
                              fontSize: kIsWeb
                                  ? AppSizes(context).font.large * 1.3
                                  : AppSizes(context).font.large,
                              color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: kIsWeb
                                ? AppSizes(context).space.small * 0.1
                                : AppSizes(context).space.small * 0.5,
                          ),
                          if (pokemon.image.isNotEmpty)
                            Image.network(
                              pokemon.image,
                              height: sizes.height * 0.25,
                              fit: BoxFit.contain,
                            ),
                          const SizedBox(height: 16),
                          Text(
                            pokemon.name,
                            style: TextStyle(
                              fontSize: sizes.font.large,
                              color: isDark ? AppColors.darkPrimaryText : AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (isFav)
                            Text(
                              'In favourites',
                              style: TextStyle(
                                fontSize: sizes.font.medium,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: isFav ? Colors.green : Colors.grey,
                                ),
                                onPressed: () {
                                  store.addFavourite(pokemon);
                                  showSuccessToast(context, 'Added to favourites');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: isFav ? Colors.red : Colors.grey,
                                ),
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
                          const SizedBox(height: 16),

                          Padding(
                            padding: kIsWeb
                                ? EdgeInsetsGeometry.symmetric(
                                    horizontal: AppSizes(context).padding.medium * 6,
                                  )
                                : EdgeInsetsGeometry.all(0),
                            child: Column(
                              children: [
                                _StatRow(label: "HP", value: pokemon.hp),
                                _StatRow(label: "Attack", value: pokemon.attack),
                                _StatRow(label: "Defense", value: pokemon.defense),
                                _StatRow(label: "Speed", value: pokemon.speed),
                                const SizedBox(height: 16),
                                AppButton(
                                  text: 'See Favourites',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const PokemonFavouritesPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final int? value;
  const _StatRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final safeValue = value ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: safeValue / 150,
              backgroundColor: Colors.grey.shade300,
              color: Colors.pinkAccent,
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 8),
          Text(safeValue.toString()),
        ],
      ),
    );
  }
}
