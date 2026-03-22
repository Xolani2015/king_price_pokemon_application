import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:king_price_pokemon_application/models/pokemon_model.dart';

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<PokemonModel>> fetchPokemon({int offset = 0, int limit = 20}) async {
    final response = await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);

      final detailedResults = await Future.wait(
        results.map((pokemon) async {
          final detailRes = await http.get(Uri.parse(pokemon['url']));
          if (detailRes.statusCode == 200) {
            final detailData = json.decode(detailRes.body);
            return PokemonModel.fromJson(detailData);
          }
          return PokemonModel(
            name: pokemon['name'],
            image: '',
            hp: 0,
            attack: 0,
            defense: 0,
            speed: 0,
          );
        }),
      );

      return detailedResults;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}
