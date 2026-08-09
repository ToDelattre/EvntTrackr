class UserStats {
  final int totalEvents;
  final int totalArtists;
  final int totalPerformances;
  final List<int> festivalVsConcert;
  final List<ArtistStat> mostSeenArtists;
  final List<ArtistPerformanceStat> bestPerformances;
  final List<DistributionStat> eventDistribution;
  final List<DistributionStat> favouriteMonths;
  final double totalSpent;
  final double totalSpentLast12Months;

  UserStats({
    required this.totalEvents,
    required this.totalArtists,
    required this.totalPerformances,
    required this.festivalVsConcert,
    required this.mostSeenArtists,
    required this.bestPerformances,
    required this.eventDistribution,
    required this.favouriteMonths,
    required this.totalSpent,
    required this.totalSpentLast12Months,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
       totalEvents: json['total_events'] ?? 0,
      totalArtists: json['total_artists'] ?? 0,
      totalPerformances: json['total_performances'] ?? 0,
      festivalVsConcert: json['festival_vs_concert'] != null 
          ? List<int>.from(json['festival_vs_concert'])
          : [],
      mostSeenArtists: (json['most_seen_artists'] as List?)
          ?.map((e) => ArtistStat.fromJson(e))
          .toList() ?? [],
      bestPerformances: (json['best_performances'] as List?)
          ?.map((e) => ArtistPerformanceStat.fromJson(e))
          .toList() ?? [],
      eventDistribution: (json['event_distribution'] as List?)
          ?.map((e) => DistributionStat.fromJson(e))
          .toList() ?? [],
      favouriteMonths: (json['favourite_months'] as List?)
          ?.map((e) => DistributionStat.fromJson(e))
          .toList() ?? [],
      totalSpent: (json['total_spent'] as num?)?.toDouble() ?? 0.0,
      totalSpentLast12Months: (json['total_spent_last_12_months'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ArtistStat {
  final int id;
  final String name;
  final int count;

  ArtistStat({required this.id, required this.name, required this.count});

  factory ArtistStat.fromJson(Map<String, dynamic> json) {
    return ArtistStat(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class ArtistPerformanceStat {
  final int id;
  final String name;
  final int count;
  final double average;

  ArtistPerformanceStat({
    required this.id,
    required this.name,
    required this.count,
    required this.average,
  });

  factory ArtistPerformanceStat.fromJson(Map<String, dynamic> json) {
    return ArtistPerformanceStat(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class DistributionStat {
  final String name;
  final int count;

  DistributionStat({required this.name, required this.count});

  factory DistributionStat.fromJson(Map<String, dynamic> json) {
    return DistributionStat(
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}
