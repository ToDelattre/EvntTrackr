import 'dart:convert';
import 'package:http/http.dart' as http;

class OSMService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  Future<List<Map<String, dynamic>>> searchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse('$_baseUrl?q=${Uri.encodeComponent(query)}&format=json&addressdetails=1&limit=5');
      final response = await http.get(uri, headers: {
        'User-Agent': 'evnttrackr/1.0',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        
        return data.map((item) {
          final address = item['address'] as Map<String, dynamic>?;
          String name = item['name'] ?? '';
          
          if (address != null) {
            final city = address['city'] ?? address['town'] ?? address['village'] ?? address['county'];
            if (city != null && city != name) {
              name = '$name, $city';
            }
          }
          
          return {
            'id': -1, // Use -1 to indicate it's from API, not local DB
            'label': name,
          };
        }).toList();
      }
    } catch (e) {
      print('Error searching OSM: $e');
    }
    
    return [];
  }
}
