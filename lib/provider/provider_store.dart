import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class PokemonStore extends ChangeNotifier {
  final List<PokemonModel> _favourites = [];

  List<PokemonModel> get favourites => List.unmodifiable(_favourites);

  void addFavourite(PokemonModel poke) {
    if (!_favourites.contains(poke)) {
      _favourites.add(poke);
      notifyListeners();
    }
  }

  void removeFavourite(PokemonModel poke) {
    _favourites.remove(poke);
    notifyListeners();
  }

  bool isFavourite(PokemonModel poke) {
    return _favourites.contains(poke);
  }
}
