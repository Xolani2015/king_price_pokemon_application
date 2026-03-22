import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class AppCard extends StatelessWidget {
  final PokemonModel pokemon;
  final bool isFav;
  final VoidCallback? onTap;

  const AppCard({super.key, required this.pokemon, required this.isFav, this.onTap});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 5,
            shadowColor: AppColors.searchTextAndBorder,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isFav ? const BorderSide(color: Colors.green, width: 2) : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pokemon.image.isNotEmpty)
                    Image.network(pokemon.image, height: sizes.height * 0.08, fit: BoxFit.contain),
                  const SizedBox(height: 2),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: sizes.font.small,
                      color: isDark ? AppColors.darkTertiaryText : AppColors.tertiaryText,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isFav)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.check_circle, color: Colors.green, size: 20),
            ),
        ],
      ),
    );
  }
}
