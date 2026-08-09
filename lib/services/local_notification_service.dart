import 'dart:math';
import 'package:intl/intl.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:evnttrackr/models/event.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    // Handle notification tap if needed
  }

  Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  Future<void> scheduleEventNotification(Event event, {bool enable1Week = true, bool enable1Day = true}) async {
    final now = DateTime.now();
    final locale = LocaleSettings.currentLocale.languageCode;
    final formatter = event.type == 1 ? DateFormat.yMd(locale) : DateFormat.yMd(locale).add_Hm();
    final dateStr = formatter.format(event.date);

    String locationStr = event.location != null && event.location!.isNotEmpty 
        ? event.location! 
        : '-';

    String detailsStr = t.notifications.details(date: dateStr, location: locationStr);
    
    // 1 semaine avant
    final date1Week = event.date.subtract(const Duration(days: 7));
    if (enable1Week && date1Week.isAfter(now)) {
      await _schedule(
        id: event.id,
        event: event,
        scheduledDate: date1Week,
        timeStr: t.notifications.time1Week,
        detailsStr: detailsStr,
      );
    }

    // 24 heures avant
    final date24h = event.date.subtract(const Duration(days: 1));
    if (enable1Day && date24h.isAfter(now)) {
      await _schedule(
        id: event.id + 1000000,
        event: event,
        scheduledDate: date24h,
        timeStr: t.notifications.time24h,
        detailsStr: detailsStr,
      );
    }
  }

  Future<void> _schedule({
    required int id,
    required Event event,
    required DateTime scheduledDate,
    required String timeStr,
    required String detailsStr,
  }) async {
    final titles = t.notifications.titles;
    final randomTitle = titles[Random().nextInt(titles.length)];
    
    String mainBody = event.gotTicket 
      ? t.notifications.withTicket(name: event.name, time: timeStr)
      : t.notifications.withoutTicket(name: event.name, time: timeStr);
      
    String fullBody = '$mainBody\n\n$detailsStr';

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: randomTitle,
      body: fullBody,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'event_reminder_channel',
          t.notifications.channelName,
          channelDescription: t.notifications.channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(fullBody),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: scheduledDate.toIso8601String(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelEventNotifications(int eventId) async {
    await flutterLocalNotificationsPlugin.cancel(id: eventId);
    await flutterLocalNotificationsPlugin.cancel(id: eventId + 1000000);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> syncNotifications(List<dynamic> eventsData, {bool enable1Week = true, bool enable1Day = true}) async {
    await cancelAllNotifications();
    if (!enable1Week && !enable1Day) return;
    
    for (var e in eventsData) {
      final event = Event.fromJson(e);
      await scheduleEventNotification(event, enable1Week: enable1Week, enable1Day: enable1Day);
    }
  }
}
