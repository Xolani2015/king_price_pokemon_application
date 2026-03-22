class Pokemon {
  final String name;
  final String image;
  final int hp;
  final int attack;
  final int defense;
  final int speed;

  Pokemon({
    required this.name,
    required this.image,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as List? ?? [];

    int getStat(String name) {
      try {
        return stats.firstWhere((s) => s['stat']['name'] == name)['base_stat'] ?? 0;
      } catch (_) {
        return 0;
      }
    }

    return Pokemon(
      name: json['name'] ?? '',
      image: json['sprites']?['front_default'] ?? '',
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
      speed: getStat('speed'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'speed': speed,
    };
  }
}
