import 'artist.dart';

class Event {
  final int id;
  final String name;
  final DateTime date;
  final DateTime? endDate;
  final int type;
  final String? notes;
  final String? location;
  final int? locationId;
  final double? price;
  final bool gotTicket;
  final List<Artist> artists;

  Event({
    required this.id,
    required this.name,
    required this.date,
    this.endDate,
    required this.type,
    this.notes,
    this.location,
    this.locationId,
    this.price,
    required this.gotTicket,
    this.artists = const [],
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']).toLocal() : DateTime.now(),
      endDate: json['enddate'] != null ? DateTime.parse(json['enddate']).toLocal() : null,
      type: (json['type'] as num?)?.toInt() ?? 0,
      notes: json['notes'],
      location: json['location'],
      locationId: (json['location_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      gotTicket: json['gotTicket'] ?? false,
      artists: (json['artists'] as List?)
          ?.map((i) => Artist.fromJson(i))
          .toList() ?? [],
    );
  }
}
