class UserAchievement {
  final int id;
  final String label;
  final String icon;
  final String description;
  final String rarity;
  final DateTime? unlockedAt;

  UserAchievement({
    required this.id,
    required this.label,
    required this.icon,
    required this.description,
    required this.rarity,
    this.unlockedAt,
  });

  bool get isUnlocked => unlockedAt != null;

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      id: json['id'] ?? 0,
      label: json['label'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
      rarity: json['rarity'] ?? '',
      unlockedAt: json['unlocked_at'] != null
          ? DateTime.parse(json['unlocked_at'])
          : null,
    );
  }
}
