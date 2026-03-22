import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/views/pokemonList/pokemon_list_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_Details_viewmodel.dart';
import 'package:king_price_pokemon_application/views/pokemonDetails/pokemon_details_page.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);

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
          page: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Pokémon...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: vm.updateSearch,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: vm.scrollController,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: vm.filteredPokemon.length + (vm.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < vm.filteredPokemon.length) {
                      final Pokemon poke = vm.filteredPokemon[index];
                      return InkWell(
                        onTap: () {
                          final detailsVm = PokemonDetailsViewmodel();
                          detailsVm.loadPokemonDetails(poke);

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
                        child: Card(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          elevation: 5,
                          shadowColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (poke.image.isNotEmpty)
                                  Image.network(
                                    poke.image,
                                    height: sizes.height * 0.1,
                                    fit: BoxFit.contain,
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                    fontSize: sizes.font.medium,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _StatBar(label: "HP", value: poke.hp, color: Colors.green),
                                _StatBar(label: "Speed", value: poke.speed),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int? value;
  final Color color;
  const _StatBar({required this.label, this.value, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    final safeValue = value ?? 0;
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        LinearProgressIndicator(
          value: safeValue / 100,
          backgroundColor: Colors.grey.shade300,
          color: color,
          minHeight: 6,
        ),
      ],
    );
  }
}
