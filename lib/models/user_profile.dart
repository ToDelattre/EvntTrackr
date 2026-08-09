import './achievement.dart';

class UserProfile {
  final String username;
  final int totalEvents;
  final int totalArtists;
  final double average;
  final DateTime memberSince;
  final List<Achievement> achievements;

  UserProfile({
    required this.username,
    required this.totalEvents,
    required this.totalArtists,
    required this.average,
    required this.memberSince,
    required this.achievements,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? 'User',
      totalEvents: json['totalEvents'] ?? 0,
      totalArtists: json['totalArtists'] ?? 0,
      average: (json['average'] ?? 0).toDouble(),
      memberSince: json['memberSince'] != null 
          ? DateTime.parse(json['memberSince']) 
          : DateTime.now(),
      achievements: (json['achievements'] as List?)
          ?.map((i) => Achievement.fromJson(i))
          .toList() ?? [],
    );
  }
}
