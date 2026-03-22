import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/helpers/app_colors.dart';
import 'package:king_price_pokemon_application/helpers/app_sizes.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
            elevation: kIsWeb ? AppSizes(context).height * 0.005 : AppSizes(context).height * 0.002,
            shadowColor: isDark ? AppColors.darkSearchTextAndBorder : AppColors.searchTextAndBorder,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isFav ? const BorderSide(color: Colors.green, width: 2) : BorderSide.none,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pokemon.image.isNotEmpty)
                      Image.network(
                        pokemon.image,
                        height: kIsWeb ? sizes.height * 0.1 : sizes.height * 0.08,
                        fit: BoxFit.contain,
                      ),
                    const SizedBox(height: 2),
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: kIsWeb ? sizes.font.large * 0.5 : sizes.font.large * 0.35,
                        color: isDark ? AppColors.darkTertiaryText : AppColors.tertiaryText,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
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
