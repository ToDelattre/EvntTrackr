import 'package:evnttrackr/models/user_stats.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class StatsPage extends ConsumerStatefulWidget {
  const StatsPage({super.key});

  @override
  ConsumerState<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends ConsumerState<StatsPage> {
  Future<UserStats>? _statsData;
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  @override
  void initState() {
    super.initState();
    _statsData = _fetchStatsData();
  }

  Future<UserStats> _fetchStatsData() async {
    final statsResponse = await _dbService.getUserStats();
    return UserStats.fromJson(statsResponse);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(t.stats.myStats),
      ),
      body: FutureBuilder<UserStats>(
        future: _statsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(t.errors.error));
          }
          if (!snapshot.hasData) {
            return Center(child: Text(t.common.noDataAvailable));
          }

          final stats = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () {
              setState(() {
                _statsData = _fetchStatsData();
              });
              return _statsData!;
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 120.0),
              children: [
                _buildCategoryHeader(t.stats.myStats, theme),
                _buildGlobalStats(context, stats),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.stats.expenses, theme),
                _buildSpendingStats(context, stats),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.stats.eventDistribution, theme),
                _buildFestivalVsConcertChart(context, stats.festivalVsConcert),
                const SizedBox(height: 16),
                _buildEventDistributionChart(context, stats.eventDistribution),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.stats.mostSeenArtists, theme),
                _buildMostSeenArtists(context, stats.mostSeenArtists),
                const SizedBox(height: 24),
                _buildCategoryHeader(t.stats.bestPerformances, theme),
                _buildBestPerformances(context, stats.bestPerformances),
                const SizedBox(height: 24),
                _buildContactUs(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 16.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildGlobalStats(BuildContext context, UserStats stats) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildStatItem(context, t.profile.totalEvents,
                  stats.totalEvents.toString(), Icons.event_available_rounded),
            ),
            Expanded(
              child: _buildStatItem(context, t.profile.totalArtists,
                  stats.totalArtists.toString(), Icons.people_outline_rounded),
            ),
            Expanded(
              child: _buildStatItem(context, t.stats.totalPerformances,
                  stats.totalPerformances.toString(), Icons.mic_external_on_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingStats(BuildContext context, UserStats stats) {
    final theme = Theme.of(context);
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: LocaleSettings.currentLocale.languageCode);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildStatItem(context, t.common.thisYear,
                  formatCurrency.format(stats.totalSpentLast12Months), Icons.calendar_today_rounded),
            ),
            Expanded(
              child: _buildStatItem(context, t.common.total,
                  formatCurrency.format(stats.totalSpent), Icons.account_balance_wallet_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFestivalVsConcertChart(
      BuildContext context, List<int> festivalVsConcert) {
    final theme = Theme.of(context);
    final festivalColor = theme.colorScheme.primary;
    final concertColor = theme.colorScheme.tertiary;
    final total = festivalVsConcert[0] + festivalVsConcert[1];

    if (total == 0) return const SizedBox.shrink();

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      color: festivalColor,
                      value: festivalVsConcert[0].toDouble(),
                      title:
                          '${(festivalVsConcert[0] / total * 100).toStringAsFixed(0)}%',
                      radius: 60,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: concertColor,
                      value: festivalVsConcert[1].toDouble(),
                      title:
                          '${(festivalVsConcert[1] / total * 100).toStringAsFixed(0)}%',
                      radius: 60,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(festivalColor,
                    '${t.events.festival} (${festivalVsConcert[0]})'),
                const SizedBox(width: 16),
                _buildLegendItem(
                    concertColor, '${t.events.concert} (${festivalVsConcert[1]})'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventDistributionChart(
      BuildContext context, List<DistributionStat> eventDistribution) {
    final theme = Theme.of(context);
    eventDistribution.sort((a, b) {
      if (a.name == 'stats.before') return -1;
      if (b.name == 'stats.before') return 1;
      return a.name.compareTo(b.name);
    });

    final minYearStr = eventDistribution
        .firstWhere((e) => e.name != 'stats.before',
            orElse: () =>
                DistributionStat(name: DateTime.now().year.toString(), count: 0))
        .name;

    final barColors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.primaryContainer,
      theme.colorScheme.secondaryContainer,
      theme.colorScheme.tertiaryContainer,
    ];
    final double maxCount = eventDistribution.isEmpty 
        ? 0 
        : eventDistribution
            .map((e) => e.count)
            .reduce((a, b) => a > b ? a : b)
            .toDouble();

    if (maxCount == 0) return const SizedBox.shrink();

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  maxY: maxCount * 1.2,
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: eventDistribution.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.count.toDouble(),
                          color: barColors[index % barColors.length],
                          width: 24,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value.toInt() >= eventDistribution.length) return Container();
                          final count = eventDistribution[value.toInt()].count;
                          if (count == 0) return Container();
                          return Text(count.toString(),
                              style: const TextStyle(fontSize: 12));
                        },
                        reservedSize: 20,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value.toInt() >= eventDistribution.length) return Container();
                          final name = eventDistribution[value.toInt()].name;
                          String text = name;
                          if (name == 'stats.before') {
                            text = t.stats.stats_before(minYearStr: minYearStr);
                          } else if (name.startsWith('stats')) {
                            // failsafe
                            text = name.split('.').last;
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 4.0,
                            child: Text(text, style: const TextStyle(fontSize: 12)),
                          );
                        },
                        reservedSize: 28,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: AppColors.separator,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: AppColors.separator, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildMostSeenArtists(
    BuildContext context,
    List<ArtistStat> artists,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: artists.asMap().entries.map((entry) {
          final artist = entry.value;
          final isLast = entry.key == artists.length - 1;
          return Column(
            children: [
              ListTile(
                title: Text(artist.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${artist.count}',
                    style: TextStyle(
                      color: theme.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast) Divider(indent: 16, endIndent: 16, height: 1, color: theme.dividerColor.withValues(alpha: 0.05)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBestPerformances(
      BuildContext context, List<ArtistPerformanceStat> artists) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: artists.asMap().entries.map((entry) {
          final artist = entry.value;
          final isLast = entry.key == artists.length - 1;
          return Column(
            children: [
              ListTile(
                title: Text(artist.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                    const SizedBox(width: 4),
                    Text(
                      artist.average.toStringAsFixed(2),
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${artist.count})',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (!isLast) Divider(indent: 16, endIndent: 16, height: 1, color: theme.dividerColor.withValues(alpha: 0.05)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactUs(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(t.stats.didntFindWhatYouWereLookingFor,
                style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'evnt.trackr@gmail.com',
                  queryParameters: {
                    'subject': t.stats.stats_email_subject,
                  },
                );

                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t.stats.tellUs,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )),
                  const SizedBox(width: 8),
                  Icon(Icons.email_rounded, color: theme.colorScheme.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.onPrimaryContainer, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
