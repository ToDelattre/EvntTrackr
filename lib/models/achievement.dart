class Achievement {
  final String icon;
  final String name;
  final String rarity;
  final String description;
  final DateTime unlockedAt;

  Achievement({
    required this.icon,
    required this.name,
    required this.rarity,
    required this.description,
    required this.unlockedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      icon: json['icon'] ?? '',
      name: json['name'] ?? '',
      rarity: json['rarity'] ?? '',
      description: json['description'] ?? '',
      unlockedAt: DateTime.parse(json['unlocked_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
