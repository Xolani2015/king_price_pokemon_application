class PokemonModel {
  final String name;
  final String image;
  final int hp;
  final int attack;
  final int defense;
  final int speed;

  PokemonModel({
    required this.name,
    required this.image,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as List? ?? [];
    int getStat(String name) {
      try {
        return stats.firstWhere((s) => s['stat']['name'] == name)['base_stat'] ?? 0;
      } catch (_) {
        return 0;
      }
    }

    return PokemonModel(
      name: json['name'] ?? '',
      image: json['sprites']?['front_default'] ?? '',
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
      speed: getStat('speed'),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'hp': hp,
    'attack': attack,
    'defense': defense,
    'speed': speed,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonModel && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
