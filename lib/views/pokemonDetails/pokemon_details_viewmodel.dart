import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class PokemonDetailsViewmodel extends ChangeNotifier {
  Pokemon? pokemonDetails;

  void loadPokemonDetails(Pokemon poke) {
    pokemonDetails = poke;
    notifyListeners();
  }
}
