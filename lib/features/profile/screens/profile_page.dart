import 'package:evnttrackr/features/profile/screens/achievements_page.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/models/achievement.dart';
import 'package:evnttrackr/models/event.dart';
import 'package:evnttrackr/models/user_profile.dart';
import 'package:evnttrackr/features/profile/screens/stats_page.dart';
import 'package:evnttrackr/widgets/event_card.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Future<Map<String, dynamic>>? _profileData;
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  @override
  void initState() {
    super.initState();
    _profileData = _fetchProfileData();
  }

  String _getAchievementName(BuildContext context, String achievementKey) {
    switch (achievementKey) {
      case 'firstStep':
        return t.achievements.achievements_firstStep;
      case 'rookieCollector':
        return t.achievements.achievements_rookieCollector;
      case 'musicCritic':
        return t.achievements.achievements_musicCritic;
      case 'curious':
        return t.achievements.achievements_curious;
      case 'regular':
        return t.achievements.achievements_regular;
      case 'pillar':
        return t.achievements.achievements_pillar;
      case 'headliner':
        return t.achievements.achievements_headliner;
      case 'musicPokedex':
        return t.achievements.achievements_musicPokedex;
      case 'trueFan':
        return t.achievements.achievements_trueFan;
      case 'superFan':
        return t.achievements.achievements_superFan;
      case 'dieHardFan':
        return t.achievements.achievements_dieHardFan;
      case 'loyal':
        return t.achievements.achievements_loyal;
      case 'marathoner':
        return t.achievements.achievements_marathoner;
      case 'eclectic':
        return t.achievements.achievements_eclectic;
      case 'discoverer':
        return t.achievements.achievements_discoverer;
      case 'globetrotter':
        return t.achievements.achievements_globetrotter;
      case 'archaeologist':
        return t.achievements.achievements_archaeologist;
      case 'nightOwl':
        return t.achievements.achievements_nightOwl;
      case 'oops':
        return t.achievements.achievements_oops;
      case 'summerFest':
        return t.achievements.achievements_summerFest;
      case 'liveLegend':
        return t.achievements.achievements_liveLegend;
      case 'pioneer':
        return t.achievements.achievements_pioneer;
      case 'venueRegular':
        return t.achievements.achievements_venueRegular;
      case 'venuePillar':
        return t.achievements.achievements_venuePillar;
      case 'venueLegend':
        return t.achievements.achievements_venueLegend;
      default:
        return achievementKey;
    }
  }

  Future<Map<String, dynamic>> _fetchProfileData() async {
    final profileData = await _dbService.getMyProfile();
    final latestEventResponse = await _dbService.getLatestEvents(limit: 1);
    final upcomingEventResponse = await _dbService.getUpcomingEvents(limit: 1);

    return {
      'profile': profileData != null ? UserProfile.fromJson(profileData) : null,
      'latestEvent': latestEventResponse.isNotEmpty
          ? Event.fromJson(latestEventResponse.first)
          : null,
      'upcomingEvent': upcomingEventResponse.isNotEmpty
          ? Event.fromJson(upcomingEventResponse.first)
          : null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = LocaleSettings.currentLocale.languageCode;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(t.profile.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts_rounded),
            onPressed: _showManageAccountsBottomSheet,
            tooltip: t.settings.editprofile,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(t.errors.error));
          }
          if (!snapshot.hasData || snapshot.data!['profile'] == null) {
            return Center(child: Text(t.common.noDataAvailable));
          }

          final UserProfile profile = snapshot.data!['profile'];
          final Event? latestEvent = snapshot.data!['latestEvent'];
          final Event? upcomingEvent = snapshot.data!['upcomingEvent'];

          return RefreshIndicator(
            onRefresh: () {
              setState(() {
                _profileData = _fetchProfileData();
              });
              return _profileData!;
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 120.0),
              children: [
                _buildProfileHeader(context, profile, locale),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.stats.myStats, theme),
                _buildStats(context, profile),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.profile.achievements, theme),
                _buildAchievements(context, profile.achievements, locale),
                if (latestEvent != null) ...[
                  const SizedBox(height: 24),
                  _buildCategoryHeader(t.profile.lastEvent, theme),
                  EventCard(
                    id: latestEvent.id.toString(),
                    title: latestEvent.name,
                    date: latestEvent.date,
                    endDate: latestEvent.endDate,
                    location: latestEvent.location ?? '',
                    artists: latestEvent.artists
                        .map((a) => Artist(name: a.name, isHeadliner: a.headliner))
                        .toList(),
                    eventType: EventType.values[latestEvent.type - 1],
                  ),
                ],
                if (upcomingEvent != null) ...[
                  const SizedBox(height: 24),
                  _buildCategoryHeader(t.profile.nextEvent, theme),
                  EventCard(
                    id: upcomingEvent.id.toString(),
                    title: upcomingEvent.name,
                    date: upcomingEvent.date,
                    endDate: upcomingEvent.endDate,
                    location: upcomingEvent.location ?? '',
                    artists: upcomingEvent.artists
                        .map((a) => Artist(name: a.name, isHeadliner: a.headliner))
                        .toList(),
                    eventType: EventType.values[upcomingEvent.type - 1],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 24.0, bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProfile profile, String locale) {
    final theme = Theme.of(context);
    final String initial = profile.username.isNotEmpty ? profile.username[0].toUpperCase() : '?';

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initial,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.username,
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: theme.dividerColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${t.profile.memberSince} ${DateFormat.yMMMMd(locale).format(profile.memberSince)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, UserProfile profile) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shadowColor: theme.shadowColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              theme.cardColor,
              theme.cardColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildStatItem(context, t.profile.totalEvents, profile.totalEvents.toString(), Icons.event_available_rounded)),
                Container(width: 1, height: 40, color: theme.dividerColor.withOpacity(0.1)),
                Expanded(child: _buildStatItem(context, t.profile.totalArtists, profile.totalArtists.toString(), Icons.people_outline_rounded)),
                Container(width: 1, height: 40, color: theme.dividerColor.withOpacity(0.1)),
                Expanded(child: _buildStatItem(context, t.profile.averageRating, profile.average.toStringAsFixed(2), Icons.star_rounded, iconColor: Colors.amber)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StatsPage()),
                  );
                },
                icon: const Icon(Icons.bar_chart_rounded, size: 20),
                label: Text(t.profile.viewMyStats),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, {Color? iconColor}) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: iconColor ?? theme.colorScheme.primary.withOpacity(0.7), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildAchievements(BuildContext context, List<Achievement> achievements, String locale) {
    final theme = Theme.of(context);
    const int maxAchievementsToShow = 15;

    final rarityOrder = {
      'legendary': 5,
      'epic': 4,
      'rare': 3,
      'uncommon': 2,
      'common': 1,
    };

    final rarityColor = {
      'legendary': Colors.amber,
      'epic': Colors.purple,
      'rare': Colors.blue,
      'uncommon': Colors.green,
      'common': Colors.grey.shade600,
    };

    achievements.sort((a, b) {
      final rarityA = rarityOrder[a.rarity] ?? 0;
      final rarityB = rarityOrder[b.rarity] ?? 0;
      return rarityB.compareTo(rarityA);
    });

    final displayedAchievements = achievements.length > maxAchievementsToShow
        ? achievements.take(maxAchievementsToShow).toList()
        : achievements;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: displayedAchievements.map((ach) {
                final color = rarityColor[ach.rarity] ?? Colors.grey;
                final String rawKey = ach.name.contains('.') ? ach.name.split('.').last : ach.name;
                final String achievementName = _getAchievementName(context, rawKey);
                return Tooltip(
                  message: '$achievementName\n${DateFormat.yMMMMd(locale).format(ach.unlockedAt)}',
                  child: Chip(
                    avatar: Text(ach.icon, style: const TextStyle(fontSize: 16)),
                    label: Text(
                      achievementName, 
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
                    ),
                    backgroundColor: color.withValues(alpha: 0.15),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AchievementsPage()),
                  );
                },
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: Text(t.common.seeAll),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showManageAccountsBottomSheet() async {
    final profileData = await _profileData;
    if (profileData == null || !mounted || profileData['profile'] == null) return;

    final UserProfile profile = profileData['profile'];
    final TextEditingController usernameController = TextEditingController(text: profile.username);
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                t.settings.profilsettings,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: t.auth.username,
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final newUsername = usernameController.text.trim();
                        if (newUsername.isEmpty) return;

                        try {
                          await _dbService.setUsername(newUsername);

                          if (context.mounted) {
                            Navigator.pop(context);
                            setState(() {
                              _profileData = _fetchProfileData();
                            });
                            NotificationHelper.showSuccess(context, t.settings.profileUpdated);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            NotificationHelper.showError(context, t.errors.error);
                          }
                        }
                      },
                      child: Text(t.common.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
