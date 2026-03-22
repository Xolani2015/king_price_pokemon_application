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

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sizes = AppSizes(context);

    return Consumer<PokemonDetailsViewmodel>(
      builder: (context, vm, child) {
        final PokemonModel? poke = vm.pokemonDetails;

        return AppTemplate(
          title: poke?.name ?? 'Pokémon Details',
          currentPage: AppPage.pokemonDetail,
          isShowTopBar: true,
          hasBack: true,
          showFloatingActionButton: true,
          page: poke == null
              ? const Center(child: Text('No Pokémon selected'))
              : Consumer<PokemonStore>(
                  builder: (context, store, child) {
                    final isFav = store.isFavourite(poke);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (poke.image.isNotEmpty)
                            Image.network(
                              poke.image,
                              height: sizes.height * 0.25,
                              fit: BoxFit.contain,
                            ),
                          const SizedBox(height: 16),
                          Text(
                            poke.name,
                            style: TextStyle(
                              fontSize: sizes.font.large,
                              color: isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (isFav)
                            Text(
                              'Already in favourites',
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
                                  store.addFavourite(poke);
                                  showSuccessToast(context, '${poke.name} added to favourites');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: isFav ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  if (isFav) {
                                    store.removeFavourite(poke);
                                    showSuccessToast(
                                      context,
                                      '${poke.name} removed from favourites',
                                    );
                                  } else {
                                    showErrorToast(context, '${poke.name} is not in favourites');
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _StatRow(label: "HP", value: poke.hp),
                          _StatRow(label: "Attack", value: poke.attack),
                          _StatRow(label: "Defense", value: poke.defense),
                          _StatRow(label: "Speed", value: poke.speed),
                          const SizedBox(height: 16),
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
