import 'package:evnttrackr/models/user_achievement.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class AchievementsPage extends ConsumerStatefulWidget {
  const AchievementsPage({super.key});

  @override
  ConsumerState<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends ConsumerState<AchievementsPage> {
  Future<List<UserAchievement>>? _achievementsData;
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  @override
  void initState() {
    super.initState();
    _achievementsData = _fetchAchievementsData();
  }

  Future<List<UserAchievement>> _fetchAchievementsData() async {
    final achievementsFuture = _dbService.getAllAchievements();
    final myProfileFuture = _dbService.getMyProfile();

    final responses = await Future.wait([achievementsFuture, myProfileFuture]);
    final allAchievements = responses[0] as List;
    final myProfile = responses[1] as Map<String, dynamic>?;

    final List myAchievements =
        (myProfile != null && myProfile['achievements'] is List)
            ? myProfile['achievements']
            : [];

    final unlocked = {
      for (final a in myAchievements)
        if (a['unlocked_at'] != null) a['name']: a['unlocked_at']
    };

    return allAchievements.map((a) {
      if (unlocked.containsKey(a['label'])) {
        a['unlocked_at'] = unlocked[a['label']];
      }
      return UserAchievement.fromJson(a);
    }).toList();
  }

  String _getTranslatedString(BuildContext context, String key) {
    final keyMap = {
      'achievements.firstStep': t.achievements.achievements_firstStep,
      'achievements.firstStepDescription':
          t.achievements.achievements_firstStepDescription,
      'achievements.rookieCollector': t.achievements.achievements_rookieCollector,
      'achievements.rookieCollectorDescription':
          t.achievements.achievements_rookieCollectorDescription,
      'achievements.musicCritic': t.achievements.achievements_musicCritic,
      'achievements.musicCriticDescription':
          t.achievements.achievements_musicCriticDescription,
      'achievements.curious': t.achievements.achievements_curious,
      'achievements.curiousDescription': t.achievements.achievements_curiousDescription,
      'achievements.regular': t.achievements.achievements_regular,
      'achievements.regularDescription': t.achievements.achievements_regularDescription,
      'achievements.pillar': t.achievements.achievements_pillar,
      'achievements.pillarDescription': t.achievements.achievements_pillarDescription,
      'achievements.headliner': t.achievements.achievements_headliner,
      'achievements.headlinerDescription':
          t.achievements.achievements_headlinerDescription,
      'achievements.musicPokedex': t.achievements.achievements_musicPokedex,
      'achievements.musicPokedexDescription':
          t.achievements.achievements_musicPokedexDescription,
      'achievements.trueFan': t.achievements.achievements_trueFan,
      'achievements.trueFanDescription': t.achievements.achievements_trueFanDescription,
      'achievements.superFan': t.achievements.achievements_superFan,
      'achievements.superFanDescription': t.achievements.achievements_superFanDescription,
      'achievements.dieHardFan': t.achievements.achievements_dieHardFan,
      'achievements.dieHardFanDescription':
          t.achievements.achievements_dieHardFanDescription,
      'achievements.loyal': t.achievements.achievements_loyal,
      'achievements.loyalDescription': t.achievements.achievements_loyalDescription,
      'achievements.marathoner': t.achievements.achievements_marathoner,
      'achievements.marathonerDescription':
          t.achievements.achievements_marathonerDescription,
      'achievements.eclectic': t.achievements.achievements_eclectic,
      'achievements.eclecticDescription': t.achievements.achievements_eclecticDescription,
      'achievements.discoverer': t.achievements.achievements_discoverer,
      'achievements.discovererDescription':
          t.achievements.achievements_discovererDescription,
      'achievements.globetrotter': t.achievements.achievements_globetrotter,
      'achievements.globetrotterDescription':
          t.achievements.achievements_globetrotterDescription,
      'achievements.archaeologist': t.achievements.achievements_archaeologist,
      'achievements.archaeologistDescription':
          t.achievements.achievements_archaeologistDescription,
      'achievements.nightOwl': t.achievements.achievements_nightOwl,
      'achievements.nightOwlDescription': t.achievements.achievements_nightOwlDescription,
      'achievements.oops': t.achievements.achievements_oops,
      'achievements.oopsDescription': t.achievements.achievements_oopsDescription,
      'achievements.summerFest': t.achievements.achievements_summerFest,
      'achievements_summerFestDescription':
          t.achievements.achievements_summerFestDescription,
      'achievements.liveLegend': t.achievements.achievements_liveLegend,
      'achievements.liveLegendDescription':
          t.achievements.achievements_liveLegendDescription,
      'achievements.pioneer': t.achievements.achievements_pioneer,
      'achievements.pioneerDescription': t.achievements.achievements_pioneerDescription,
      'achievements.venueRegular': t.achievements.achievements_venueRegular,
      'achievements.venueRegularDescription':
          t.achievements.achievements_venueRegularDescription,
      'achievements.venuePillar': t.achievements.achievements_venuePillar,
      'achievements.venuePillarDescription':
          t.achievements.achievements_venuePillarDescription,
      'achievements.venueLegend': t.achievements.achievements_venueLegend,
      'achievements.venueLegendDescription':
          t.achievements.achievements_venueLegendDescription,
      'rarity.common': t.achievements.rarity_common,
      'rarity.uncommon': t.achievements.rarity_uncommon,
      'rarity.rare': t.achievements.rarity_rare,
      'rarity.epic': t.achievements.rarity_epic,
      'rarity.legendary': t.achievements.rarity_legendary,
    };
    return keyMap[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final locale = LocaleSettings.currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.profile.achievements),
      ),
      body: FutureBuilder<List<UserAchievement>>(
        future: _achievementsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(t.errors.error));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(t.common.noDataAvailable));
          }

          final achievements = snapshot.data!;

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
            'common': Colors.grey.shade400,
          };

          achievements.sort((a, b) {
            if (a.isUnlocked && !b.isUnlocked) {
              return -1;
            }
            if (!a.isUnlocked && b.isUnlocked) {
              return 1;
            }

            final rarityA = rarityOrder[a.rarity] ?? 0;
            final rarityB = rarityOrder[b.rarity] ?? 0;

            return rarityA.compareTo(rarityB);
          });

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            itemCount: achievements.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              final isUnlocked = achievement.isUnlocked;
              final theme = Theme.of(context);

              return Opacity(
                opacity: isUnlocked ? 1.0 : 0.6,
                child: Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      enabled: isUnlocked,
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUnlocked 
                              ? (rarityColor[achievement.rarity]?.withValues(alpha: 0.2) ?? theme.colorScheme.primaryContainer)
                              : theme.colorScheme.surfaceContainerHighest,
                          shape: BoxShape.circle,
                        ),
                        child: isUnlocked
                            ? Text(
                                achievement.icon,
                                style: const TextStyle(fontSize: 24),
                              )
                            : Icon(
                                Icons.lock_rounded,
                                size: 24,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                      ),
                      title: Text(
                        _getTranslatedString(context, achievement.label),
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            _getTranslatedString(context, achievement.description),
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                          if (isUnlocked) ...[
                            const SizedBox(height: 8),
                            Text(
                              DateFormat.yMMMMd(locale).format(achievement.unlockedAt!),
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                            ),
                          ],
                        ],
                      ),
                      trailing: Chip(
                        label: Text(
                          _getTranslatedString(context, 'rarity.${achievement.rarity}'),
                          style: TextStyle(
                            color: isUnlocked ? Colors.white : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: isUnlocked
                            ? (rarityColor[achievement.rarity] ?? Colors.grey)
                            : theme.colorScheme.surfaceContainerHighest,
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
