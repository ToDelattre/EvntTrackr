import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Used to trigger a rebuild of events lists (instead of the old ValueNotifier)
final eventsRefreshProvider = StateProvider<int>((ref) => 0);
