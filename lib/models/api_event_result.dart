class ApiEventResult {
  final String apiId;
  final String name;
  final DateTime? date;
  final String? locationName;
  final List<String> artists;
  final int type; // 1 = Concert, 2 = Festival
  final String provider; // Ticketmaster, MusicBrainz, etc.

  ApiEventResult({
    required this.apiId,
    required this.name,
    this.date,
    this.locationName,
    required this.artists,
    required this.type,
    required this.provider,
  });
}
