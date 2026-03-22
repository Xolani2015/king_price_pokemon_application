import 'package:flutter/material.dart';
import 'package:king_price_pokemon_application/models/pokemon_model.dart';
import 'package:king_price_pokemon_application/services/pokemon_api_service.dart';

class PokemonListViewmodel extends ChangeNotifier {
  final PokemonService _pokemonService = PokemonService();

  List<PokemonModel> pokemonList = [];
  bool isLoading = false;
  int offset = 0;
  final int limit = 20;

  final ScrollController scrollController = ScrollController();

  // CONSTRUCTOR
  PokemonListViewmodel() {
    loadPokemon();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadPokemon();
    }
  }

  Future<void> loadPokemon() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final newPokemon = await _pokemonService.fetchPokemon(offset: offset, limit: limit);
      pokemonList.addAll(newPokemon);
      offset += limit;
    } catch (e) {
      debugPrint('Error fetching Pokémon: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  String searchQuery = '';

  void updateSearch(String query) {
    searchQuery = query.toLowerCase();
    notifyListeners();
  }

  List<PokemonModel> get filteredPokemon {
    if (searchQuery.isEmpty) return pokemonList;
    return pokemonList
        .where((pokemon) => pokemon.name.toLowerCase().contains(searchQuery))
        .toList();
  }

  PokemonModel? selectedPokemon;

  void selectPokemon(PokemonModel pokemon) {
    selectedPokemon = pokemon;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
