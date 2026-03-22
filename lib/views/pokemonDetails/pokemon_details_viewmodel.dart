import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class PokemonDetailsViewmodel extends ChangeNotifier {
  PokemonModel? pokemonDetails;

  void loadPokemonDetails(PokemonModel pokemon) {
    pokemonDetails = pokemon;
    notifyListeners();
  }
}
