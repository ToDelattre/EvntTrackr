import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';

class EventsList extends ConsumerStatefulWidget {
  final String rpcName;
  final String emptyMessage;
  final bool showTicketButton;
  final String? searchQuery;
  final bool isCompact;

  const EventsList({
    super.key,
    required this.rpcName,
    required this.emptyMessage,
    this.showTicketButton = false,
    this.searchQuery,
    this.isCompact = false,
  });

  @override
  ConsumerState<EventsList> createState() => _EventsListState();
}

class _EventsListState extends ConsumerState<EventsList>
    with AutomaticKeepAliveClientMixin<EventsList> {
  final List<dynamic> _events = [];
  final ScrollController _scrollController = ScrollController();
  DatabaseService get _dbService => ref.read(databaseServiceProvider);
  bool _isLoading = true;
  bool _isFetchingMore = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 15;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(EventsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _refresh();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        _hasMore) {
      _fetchEvents();
    }
  }

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      _offset = 0;
      _hasMore = true;
      _isLoading = true;
    });
    await _fetchEvents(isRefresh: true);
  }

  Future<void> _fetchEvents({bool isRefresh = false}) async {
    if (_isFetchingMore && !isRefresh) return;

    if (mounted) {
      setState(() {
        _isFetchingMore = true;
        if (!isRefresh && _offset == 0) {
          _isLoading = true;
        }
      });
    }

    try {
      final Map<String, dynamic> params = {
        'limit_param': _limit,
        'offset_param': _offset,
      };

      if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
        params['p_search'] = widget.searchQuery ?? '';
      }

      final newEvents = await _dbService.callRpc(
        widget.rpcName,
        params: params,
      );

      if (mounted) {
        setState(() {
          if (_offset == 0) {
            _events.clear();
          }
          _events.addAll(newEvents);
          _offset = _events.length;
          _hasMore = (newEvents as List).length >= _limit;
          _isLoading = false;
          _isFetchingMore = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching events for ${widget.rpcName}: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isFetchingMore = false;
        });
        NotificationHelper.showError(context, "Erreur lors du chargement des événements.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen(eventsRefreshProvider, (_, __) {
      _refresh();
    });

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_events.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.emptyMessage, textAlign: TextAlign.center),
                ),
              ),
            ),
          );
        }),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        itemCount: _events.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _events.length) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final event = _events[index];
          final artistsData = event['artists'] as List? ?? [];
          final artists = artistsData.map((artistData) {
            return Artist(
              name: artistData['name'],
              isHeadliner: artistData['headliner'] ?? false,
            );
          }).toList();

          return EventCard(
            id: event['id'].toString(),
            title: event['name'],
            date: DateTime.parse(event['date']),
            endDate: event['enddate'] != null
                ? DateTime.parse(event['enddate'])
                : null,
            location: event['location'] ?? 'N/A',
            artists: artists,
            showTicketButton: widget.showTicketButton,
            eventType: (event['type'] == 1) // 1 for festival, 2 for concert
                ? EventType.festival
                : EventType.concert,
            isCompact: widget.isCompact,
          );
        },
      ),
    );
  }
}
