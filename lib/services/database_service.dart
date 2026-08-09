import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Generic RPC call
  Future<dynamic> callRpc(String rpcName, {Map<String, dynamic>? params}) async {
    return await _client.rpc(rpcName, params: params);
  }

  // Achievement RPCs
  Future<List<dynamic>> getAllAchievements() async {
    return await _client.rpc('achievement_getall');
  }

  // User/Profile RPCs
  Future<Map<String, dynamic>?> getMyProfile() async {
    final response = await _client.rpc('user_getmyprofile');
    if (response is List && response.isNotEmpty) {
      return response.first as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> setUsername(String username) async {
    await _client.rpc('user_setusername', params: {'p_username': username});
  }

  Future<Map<String, dynamic>> getUserStats() async {
    final response = await _client.rpc('user_getstats');
    return (response as List).first as Map<String, dynamic>;
  }

  Future<void> callUserRpc(String rpcName) async {
    await _client.rpc(rpcName);
  }

  // Event RPCs
  Future<List<dynamic>> getUpcomingEvents({int limit = 1, int offset = 0}) async {
    return await _client.rpc('event_getupcoming_new', params: {
      'limit_param': limit,
      'offset_param': offset,
    });
  }

  Future<List<dynamic>> getLatestEvents({int limit = 1, int offset = 0}) async {
    return await _client.rpc('event_getlatest_new', params: {
      'limit_param': limit,
      'offset_param': offset,
    });
  }

  Future<Map<String, dynamic>> getEventById(int eventId) async {
    return await _client.rpc('event_getbyid', params: {'p_event_id': eventId}).single();
  }

  Future<void> createEvent(Map<String, dynamic> params) async {
    await _client.rpc('event_create', params: params);
  }

  Future<void> updateEvent(Map<String, dynamic> params) async {
    await _client.rpc('event_update', params: params);
  }

  Future<void> deleteEvent(int eventId) async {
    await _client.rpc('event_delete', params: {'p_event_id': eventId});
  }

  Future<void> buyTicket(int eventId) async {
    await _client.rpc('event_buyticket', params: {'event_id': eventId});
  }

  Future<void> setEventPrice(int eventId, double price) async {
    await _client.rpc('event_setprice', params: {
      'p_event_id': eventId,
      'p_price': price,
    });
  }

  // Artist RPCs
  Future<int> createArtist(String name) async {
    return await _client.rpc('artist_create', params: {'p_name': name});
  }

  Future<List<dynamic>> searchArtists(String search) async {
    return await _client.rpc('artist_findbyname', params: {'p_search': search});
  }

  Future<List<dynamic>> getArtistsByEvents(List<int> eventIds) async {
    return await _client.rpc('artist_getbyevents', params: {'event_ids': eventIds});
  }

  Future<void> toggleArtistHeadliner(int eventId, int artistId) async {
    await _client.rpc('artist_toggleheadliner', params: {
      'p_event_id': eventId,
      'p_artist_id': artistId,
    });
  }

  // Ratings RPCs
  Future<List<dynamic>> getArtistEventRatings(int eventId, int artistId) async {
    return await _client.rpc('artist_event_getratings', params: {
      'p_artist_id': artistId,
      'p_event_id': eventId,
    });
  }

  Future<void> updateArtistEventRatings({
    required int eventId,
    required int artistId,
    double? rating,
    double? setlist,
    double? sound,
    String? notes,
  }) async {
    await _client.rpc('artist_event_updateratings', params: {
      'p_artist_id': artistId,
      'p_event_id': eventId,
      'p_rating': rating,
      'p_setlist': setlist,
      'p_sound': sound,
      'p_notes': notes,
    });
  }

  // Location RPCs
  Future<int> createLocation(String label) async {
    return await _client.rpc('location_create', params: {'p_label': label});
  }

  Future<List<dynamic>> searchLocations(String search) async {
    return await _client.rpc('location_findbyname', params: {'p_search': search});
  }
}
