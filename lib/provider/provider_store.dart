import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class PokemonStore extends ChangeNotifier {
  final List<PokemonModel> _favourites = [];

  List<PokemonModel> get favourites => List.unmodifiable(_favourites);

  void addFavourite(PokemonModel pokemon) {
    if (!_favourites.contains(pokemon)) {
      _favourites.add(pokemon);
      notifyListeners();
    }
  }

  void removeFavourite(PokemonModel pokemon) {
    _favourites.remove(pokemon);
    notifyListeners();
  }

  bool isFavourite(PokemonModel pokemon) {
    return _favourites.contains(pokemon);
  }
}
