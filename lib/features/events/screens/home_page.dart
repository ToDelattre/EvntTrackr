import 'dart:async';
import 'package:evnttrackr/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isCompact = false;
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchQuery = query;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 48,
            child: SearchBar(
              controller: _searchController,
              hintText: t.common.search,
              onChanged: _onSearchChanged,
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainerHigh),
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isCompact ? Icons.view_headline_rounded : Icons.view_stream_rounded),
              tooltip: _isCompact ? "Vue normale" : "Vue compacte",
              onPressed: () {
                setState(() {
                  _isCompact = !_isCompact;
                });
              },
            ),
            const SizedBox(width: 8),
          ],
          bottom: TabBar(
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            indicatorColor: colorScheme.primary,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: const Icon(Icons.upcoming_rounded), text: t.events.upcoming, height: 56),
              Tab(icon: const Icon(Icons.history_rounded), text: t.events.past, height: 56),
              Tab(icon: const Icon(Icons.bookmarks_rounded), text: t.events.bookmarked, height: 56),
            ],
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: TabBarView(
            children: [
              EventsList(
                rpcName: 'event_getupcoming_new',
                emptyMessage: t.events.noupcoming,
                searchQuery: _searchQuery,
                isCompact: _isCompact,
              ),
              EventsList(
                rpcName: 'event_getlatest_new',
                emptyMessage: t.events.nopast,
                searchQuery: _searchQuery,
                isCompact: _isCompact,
              ),
              EventsList(
                rpcName: 'event_getbookmarked',
                emptyMessage: t.events.nobookmarked,
                showTicketButton: true,
                searchQuery: _searchQuery,
                isCompact: _isCompact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
