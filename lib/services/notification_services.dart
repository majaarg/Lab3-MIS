import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission for push notifications
    await _firebaseMessaging.requestPermission();

    // Configure the local notifications plugin
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Listen for messages in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
    });
  }

  static Future<void> _showNotification({String? title, String? body}) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'joke_channel',
        'Joke Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
