// import 'package:chat_feature/src/features/chat/models/message.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:logger/logger.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import '../export.dart';

// class NotificationsHelper {
//   // final _firebaseMessaging = FirebaseMessaging();
//   // final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   final NotificationBloc _notificationBloc;

//   NotificationsHelper(
//       this._notificationBloc, String currentUserID, bool newLogin) {
//     // _configLocalNotification();
//     OneSignal.shared.consentGranted(true);
//     OneSignal.shared.init('31bdab39-d23d-4625-a4fd-94071105bb90', iOSSettings: {
//       OSiOSSettings.autoPrompt: true,
//       OSiOSSettings.inAppLaunchUrl: true
//     });

//     OneSignal.shared
//         .setInFocusDisplayType(OSNotificationDisplayType.notification);
//     OneSignal.shared.getPermissionSubscriptionState().then((v) {
//       final playerId = v.subscriptionStatus.userId;
//       if (playerId == null) return;
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserID)
//           .update({'playerId': playerId}).catchError((e) {
//         Logger().e(e);
//       });
//     });
//     _registerNotification(currentUserID);
//   }
//   static void handleSendNotification(Message message, String playerId) async {
//     print(playerId);
//     if (playerId == null) return;

//     final notification = OSCreateNotification(
//         playerIds: [playerId],
//         mutableContent: true,
//         content: message.type == 0 ? message.content : 'Image',
//         bigPicture: message.type == 1 ? message.content : null,
//         heading: '${message.senderName}: ',
//         androidLargeIcon: message.senderPhotoUrl,
//         additionalData: {
//           'senderId': message.senderId,
//           'senderName': message.senderName,
//         },
//         androidChannelId: DIRECT_MESSAGES_CHANNEL
//         // iosAttachments: {'id1': imgUrlString},
//         );
//     OneSignal.shared
//         .postNotificationWithJson({
//           ...notification.mapRepresentation(),
//           'android_group': 'direct_messages',
//           'android_group_message': message.senderId,
//         })
//         .then(print)
//         .catchError(print);
//   }

//   void _registerNotification(String currentUserId) {
//     OneSignal.shared
//       ..setNotificationReceivedHandler((OSNotification notification) {
//         print('------FCM OnRecieve $notification');

//         final data = notification.payload.additionalData;
//         _notificationBloc.add(
//           NotificationEvent.messageNotificationReceived(
//             senderId: data['senderId'],
//             senderName: data['senderName'],
//             message: notification.payload.body,
//           ),
//         );
//       })
//       ..setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//         // will be called whenever a notification is opened/button pressed.
//         final message = result.notification.payload.additionalData;
//         print('------FCM onResume $message');
//         final senderId = message['senderId'];
//         if (senderId == null) return;
//         _notificationBloc.add(
//             NotificationEvent.messageNotificationOpened(senderId: senderId));
//       })
//       ..setPermissionObserver((OSPermissionStateChanges changes) {
//         print('------FCM PermissionObserver $changes');

//         // will be called whenever the permission changes
//         // (ie. user taps Allow on the permission prompt in iOS)
//       })
//       ..setSubscriptionObserver((OSSubscriptionStateChanges changes) {
//         // will be called whenever the subscription changes
//         //(ie. user gets registered with OneSignal and gets a user ID)
//       });
//   }
// }

// const DIRECT_MESSAGES_CHANNEL = 'db49e2b0-f363-4a5b-9f15-9499b5e56a12';
// const GROUPS_MESSAGES_CHANNEL = 'd58ea698-2478-4001-94cf-4d97e70551c5';
