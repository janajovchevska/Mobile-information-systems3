import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {

  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission for notifications granted");
    }

    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print("Device token: $token");
      await sendTokenToServer(token);
    } else {
      print("Failed to retrieve device token.");
    }

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("Token refreshed: $newToken");
      sendTokenToServer(newToken);
    });
  }

  Future<void> sendTokenToServer(String token) async {
    const String serverUrl = "https://your-backend-server.com/api/save-token";
    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        print("Token sent to server successfully.");
      } else {
        print("Failed to send token to server: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending token to server: $e");
    }
  }

  Future<void> showDailyNotification(int id, String title, String body, Duration delay) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_joke_channel',
          'Daily Jokes',
          channelDescription: 'Daily joke reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}