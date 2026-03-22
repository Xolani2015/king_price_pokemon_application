import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/views/pokemonList/pokemon_list_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_Details_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_details_page.dart';
import 'package:king_price_pokemon_application/widgets/app_card.dart';
import 'package:king_price_pokemon_application/widgets/app_search_bar.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonListViewmodel(),
      child: Consumer<PokemonListViewmodel>(
        builder: (context, vm, child) => AppTemplate(
          title: 'Pokédex',
          currentPage: AppPage.pokemonList,
          hasBack: true,
          hasMenu: true,
          isShowTopBar: true,
          showFloatingActionButton: true,
          page: Consumer<PokemonStore>(
            builder: (context, store, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedSearchBar(onChanged: vm.updateSearch),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: vm.scrollController,
                    padding: const EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (kIsWeb ||
                              defaultTargetPlatform == TargetPlatform.macOS ||
                              defaultTargetPlatform == TargetPlatform.windows ||
                              defaultTargetPlatform == TargetPlatform.linux)
                          ? 8
                          : 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: vm.filteredPokemon.length + (vm.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < vm.filteredPokemon.length) {
                        final PokemonModel pokemon = vm.filteredPokemon[index];
                        final isFav = store.isFavourite(pokemon);
                        return InkWell(
                          onTap: () {
                            final detailsVm = PokemonDetailsViewmodel();
                            detailsVm.loadPokemonDetails(pokemon);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider.value(
                                  value: detailsVm,
                                  child: const PokemonDetailPage(),
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              AppCard(
                                pokemon: pokemon,
                                isFav: isFav,
                                onTap: () {
                                  final detailsVm = PokemonDetailsViewmodel();
                                  detailsVm.loadPokemonDetails(pokemon);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChangeNotifierProvider.value(
                                        value: detailsVm,
                                        child: const PokemonDetailPage(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              child: const Center(
                                child: CircularProgressIndicator(color: AppColors.primary),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
