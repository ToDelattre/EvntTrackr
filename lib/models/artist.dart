class Artist {
  final int id;
  final String name;
  bool headliner;
  double? rating;
  double? soundRating;
  double? setlistRating;
  String? notes;

  Artist({
    required this.id,
    required this.name,
    required this.headliner,
    this.rating,
    this.soundRating,
    this.setlistRating,
    this.notes,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      headliner: json['headliner'] ?? false,
      rating: (json['rating'] as num?)?.toDouble(),
      soundRating: (json['sound_rating'] as num?)?.toDouble(),
      setlistRating: (json['setlist_rating'] as num?)?.toDouble(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'headliner': headliner,
      'rating': rating,
      'sound_rating': soundRating,
      'setlist_rating': setlistRating,
      'notes': notes,
    };
  }
}
