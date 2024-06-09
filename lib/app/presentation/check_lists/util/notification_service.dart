import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  NotificationService._internal();
  static NotificationService get instance => _instance;
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  static const AndroidInitializationSettings _initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  static const DarwinInitializationSettings _initializationSettingsIos = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  final initializationSettings = const InitializationSettings(
    android: _initializationSettingsAndroid, 
    iOS:     _initializationSettingsIos
  );

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      await notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled() ?? false;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          
        );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  Future<void> initNotifications() async {
    // * Creating a channel for local notifications on android
    await notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);
    
    /* 
    * Initializing the plugin for remote notifications
    */
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );

    await _isAndroidPermissionGranted();
    await _requestPermissions();
  }

  Future<void> cancelLocalNotification(int index) async {
    await notificationsPlugin.cancel(index);
  }

  Future<void> scheduleNotification({
    required int id,
    String? title,
    String? body,
    String? payLoad,
    required DateTime scheduledNotificationDateTime
  }) async {
    if (
      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local
      ).isBefore(
        tz.TZDateTime.now(tz.local)
      )
    ) return;

    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      payload: 'reminder',

      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local
      ),

      NotificationDetails(
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          presentBanner: true,
        ),
        android: AndroidNotificationDetails(
          _channel.id, _channel.name,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          showWhen: false
        )
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> createLocalNotify(
      int id, 
      String bodyText,
      DateTime time, 
    ) async {
    try {
      log("creating");
      await scheduleNotification(
        scheduledNotificationDateTime: time,
        title: 'Напоминание',
        body: bodyText,
        id: id,
      );
      log("created");
    } catch (e) {
      log("some");
      log(e.toString());
    }
  }

}

Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  log("Notification selected with payload: ${notificationResponse.payload}");
}