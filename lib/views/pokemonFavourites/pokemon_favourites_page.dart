import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_enums.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/provider/provider_store.dart';
import 'package:king_price_pokemon_application/widgets/app_template.dart';
import 'package:provider/provider.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';

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
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: store.favourites.length,
                itemBuilder: (context, index) {
                  final PokemonModel poke = store.favourites[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
