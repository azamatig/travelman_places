import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import '../export.dart';

class NotificationsHelper {
  final _firebaseMessaging = FirebaseMessaging();

  NotificationController get notController =>
      Modular.get<NotificationController>();

  Future<void> registerNotification(String currentUserID, bool newLogin) async {
    if (kDebugMode) return;

    if (newLogin) {
      try {
        final token = await _firebaseMessaging.getToken();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserID)
            .update({'pushToken': token});
      } catch (e) {
        Logger().e('Get Msg Tokken Error $e');
      }
    }
    _firebaseMessaging
      ..requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true))
      ..onIosSettingsRegistered.listen(
        (settings) {
          print('Settings registered: $settings');
        },
      )
      ..configure(
        onMessage: (message) async {
          print('------FCM onMessage $message');

          final data = message['data'] ?? {};
          final msg = message['notification'] ?? {};
          final groupId = message['groupId'] ?? data['groupId'];
          if (groupId == null) {
            await notController.onMessageNotificationReceived(
              senderId: message['senderId'] ?? data['senderId'],
              senderName: message['senderName'] ??
                  data['senderName'] ??
                  data['groupName'],
              message: msg['body'],
            );
          } else {
            await notController.groupMessageNotificationReceived(
              groupId: groupId,
              groupName: message['groupName'] ?? data['groupName'],
              senderName: message['senderName'] ?? data['senderName'],
              message: msg['body'],
            );
          }
        },
        onResume: (message) async {
          print('------FCM onResume $message');
          final senderId = (message['data'] ?? {})['senderId'];
          final groupId = (message['data'] ?? {})['groupId'];

          if (senderId != null) {
            await notController.onMessageNotificationOpened(senderId);
          } else if (groupId != null) {
            await notController.groupMessageNotificationOpened(groupId);
          }
        },
        onLaunch: (message) async {
          print('------FCM onLaunch $message');
          final senderId = (message['data'] ?? {})['senderId'];
          final groupId = (message['data'] ?? {})['groupId'];

          if (senderId != null) {
            await notController.onMessageNotificationOpened(senderId);
          } else if (groupId != null) {
            await notController.groupMessageNotificationOpened(groupId);
          }
        },
        onBackgroundMessage: Platform.isAndroid ? _onBackgroundMsg : null,
      );
  }
}

Future _onBackgroundMsg(Map<String, dynamic> message) async {
  Logger().i('FCM onBackgroundMessage $message');
  return;
}
